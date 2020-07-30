//
//  MoyaCacheableProvider.swift
//  swift-study
//
//  Created by 永平 on 2020/7/10.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation
import Moya
import Result

private let MoyaURLCacheCacheKey = "MoyaURLCacheCacheKey"
private let MoyaURLCacheDateKey = "MoyaURLCacheDateKey"

public enum MoyaCacheableProviderPolicy {
    case reload
    case reloadMergeConcurrent
    case returnCacheElseLoad
}

public class MoyaCacheableProvider<Target: TargetType>: MoyaProvider<Target> {
    let policy: MoyaCacheableProviderPolicy
    let cacheMaxAge: UInt

    private let requestClosureBridge: RequestClosureBridge
    private var urlCache: URLCache {
        return manager.session.configuration.urlCache ?? URLCache.shared
    }

    public init(policy: MoyaCacheableProviderPolicy,
                cacheMaxAge: UInt,
                endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
                requestClosure: @escaping RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
                stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
                callbackQueue: DispatchQueue? = nil,
                manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
                plugins: [PluginType] = [],
                trackInflights: Bool = false) {
        self.policy = policy
        self.cacheMaxAge = cacheMaxAge
        requestClosureBridge = RequestClosureBridge()
        requestClosureBridge.rawRequestClosure = requestClosure

        super.init(endpointClosure: endpointClosure,
                   requestClosure: requestClosureBridge.injectionRequestClosure,
                   stubClosure: stubClosure,
                   callbackQueue: callbackQueue,
                   manager: manager,
                   plugins: plugins,
                   trackInflights: trackInflights)

        requestClosureBridge.onProcessRequest = { request in
            var allHTTPHeaderFields = request.allHTTPHeaderFields ?? [:]
            allHTTPHeaderFields["Cache-Control"] = "no-cache"

            var request = request
            request.cachePolicy = .reloadIgnoringLocalCacheData
            request.allHTTPHeaderFields = allHTTPHeaderFields
            return request
        }
    }

    @discardableResult
    public override func request(_ target: Target,
                                 callbackQueue: DispatchQueue? = .none,
                                 progress: ProgressBlock? = .none,
                                 completion: @escaping Completion) -> Cancellable {
        guard let targetToken = target.targetToken else {
            return super.request(target, callbackQueue: callbackQueue, progress: progress, completion: completion)
        }
        if policy == .reload {
            return requestCacheable(target, callbackQueue: callbackQueue, progress: progress, completion: completion)
        } else {
            return requestMergeConcurrent(target, targetToken: targetToken, callbackQueue: callbackQueue, progress: progress, completion: completion)
        }
    }

    private func superRequest(_ target: Target,
                              callbackQueue: DispatchQueue? = .none,
                              progress: ProgressBlock? = .none,
                              completion: @escaping Completion) -> Cancellable {
        super.request(target, callbackQueue: callbackQueue, progress: progress, completion: completion)
    }

    private func requestCacheable(_ target: Target,
                                  callbackQueue: DispatchQueue? = .none,
                                  progress: ProgressBlock? = .none,
                                  completion: @escaping Completion) -> Cancellable {
        var requestCancellable: Cancellable?
        bridgeURLRequest(target) { [weak self] result in
            guard let self = self else { return }
            guard let (rawRequest, bridgeRequest) = result else {
                requestCancellable = self.superRequest(target, callbackQueue: callbackQueue, progress: progress, completion: completion)
                return
            }

            if self.cacheMaxAge > 0, self.policy == .returnCacheElseLoad {
                if let cachedResponse = self.urlCache.cachedResponse(for: bridgeRequest),
                    let httpResponse = cachedResponse.response as? HTTPURLResponse,
                    let cacheDate = cachedResponse.userInfo?[MoyaURLCacheDateKey] as? TimeInterval {
                    let diff = Date().timeIntervalSince1970 - cacheDate
                    if diff >= 0, diff < TimeInterval(self.cacheMaxAge) {
                        (callbackQueue ?? DispatchQueue.main).async {
                            completion(.success(Response(statusCode: httpResponse.statusCode, data: cachedResponse.data, request: rawRequest, response: httpResponse)))
                        }
                        return
                    }
                }
            }
            requestCancellable = self.superRequest(target, callbackQueue: callbackQueue, progress: progress, completion: { [weak self] result in
                defer {
                    completion(result)
                }
                if case let .success(resp) = result, let self = self, self.cacheMaxAge > 0 {
                    guard let response = resp.response else { return }
                    guard let url = response.url, var headerFields = response.allHeaderFields as? [String: String] else { return }
                    guard headerFields[MoyaURLCacheCacheKey] == nil else { return }

                    headerFields.removeValue(forKey: "Vary")
                    headerFields.removeValue(forKey: "Pragma")
                    headerFields["Cache-Control"] = "max-age=\(self.cacheMaxAge)"
                    headerFields[MoyaURLCacheCacheKey] = MoyaURLCacheCacheKey

                    if let newResponse = HTTPURLResponse(url: url, statusCode: response.statusCode, httpVersion: nil, headerFields: headerFields) {
                        let newCacheResponse = CachedURLResponse(response: newResponse,
                                                                 data: resp.data,
                                                                 userInfo: [MoyaURLCacheCacheKey: MoyaURLCacheCacheKey,
                                                                            MoyaURLCacheDateKey: Date().timeIntervalSince1970],
                                                                 storagePolicy: URLCache.StoragePolicy.allowedInMemoryOnly)
                        self.urlCache.storeCachedResponse(newCacheResponse, for: bridgeRequest)
                    }
                }
            })
        }
        return RunningRequestCancellable {
            requestCancellable?.cancel()
        }
    }

    private func requestMergeConcurrent(_ target: Target,
                                        targetToken: String,
                                        callbackQueue: DispatchQueue? = .none,
                                        progress: ProgressBlock? = .none,
                                        completion: @escaping Completion) -> Cancellable {
        let completionId = targetToken + UUID().uuidString

        func resultCancellable(_ req: RunningRequest) -> Cancellable {
            return RunningRequestCancellable {
                req.completions.removeValue(forKey: completionId)
                if req.completions.isEmpty {
                    RuningRequestShared.runningPool.remove(forKey: targetToken)
                    RuningRequestShared.cancellingPool.set(object: req, for: targetToken)
                    req.cancellable?.cancel()
                }
            }
        }

        if let request = RuningRequestShared.runningPool.object(for: targetToken) {
            request.completions[completionId] = completion
            return resultCancellable(request)
        } else {
            let request = RunningRequest()
            RuningRequestShared.runningPool.set(object: request, for: targetToken)
            request.completions[completionId] = completion

            request.cancellable = requestCacheable(target, callbackQueue: callbackQueue, progress: progress, completion: { [weak request] result in
                guard let request = request else {
                    return
                }
                if RuningRequestShared.cancellingPool.object(for: targetToken) === request {
                    RuningRequestShared.cancellingPool.remove(forKey: targetToken)
                }
                if RuningRequestShared.runningPool.object(for: targetToken) === request {
                    RuningRequestShared.runningPool.remove(forKey: targetToken)
                }
                request.cancellable = nil
                request.completions.forEach { _, value in
                    value(result)
                }
            })
            return resultCancellable(request)
        }
    }

    // 将 POST 请求桥接成 GET 带参的请求，便于手动管理缓存
    private func bridgeURLRequest(_ target: Target, completion: @escaping (((URLRequest, URLRequest)?) -> Void)) {
        requestClosure(endpointClosure(target)) { res in
            if case let .success(request) = res, let url = request.url, let keyToken = target.targetToken {
                var bridgeRequest = URLRequest(url: url.appendingPathComponent(keyToken))
                bridgeRequest.httpMethod = "GET"
                completion((request, bridgeRequest))
            } else {
                completion(nil)
            }
        }
    }

    public func removeLazyCache(_ target: Target) {
        bridgeURLRequest(target) { [weak self] result in
            if let self = self, let (rawRequest, bridgeRequest) = result {
                // removeCachedResponse 不起效，使用保存空代替
                // self.urlCache.removeCachedResponse(for: bridgeRequest)
                if let url = rawRequest.url, let newResponse = HTTPURLResponse(url: url, statusCode: -1, httpVersion: nil, headerFields: [:]) {
                    let newCacheResponse = CachedURLResponse(response: newResponse,
                                                             data: Data(),
                                                             userInfo: [:],
                                                             storagePolicy: URLCache.StoragePolicy.allowedInMemoryOnly)
                    self.urlCache.storeCachedResponse(newCacheResponse, for: bridgeRequest)
                }
            }
        }
    }
}/*-+*/

/// Private - Helper

private class RunningRequest {
    var cancellable: Cancellable?
    var completions: [String: Completion] {
        set {
            lock.lock(); defer { lock.unlock() }
            _completions = newValue
        }
        get {
            lock.lock(); defer { lock.unlock() }
            return _completions
        }
    }

    private let lock = NSLock()
    private var _completions: [String: Completion] = [:]
}

private class RuningRequestShared {
    static let runningPool = RuningRequestShared()
    static let cancellingPool = RuningRequestShared()
    private let lock = NSLock()
    private var requestMap: [String: RunningRequest] = [:]

    func remove(forKey key: String) {
        lock.lock(); defer { lock.unlock() }
        requestMap.removeValue(forKey: key)
    }

    func set(object: RunningRequest, for key: String) {
        lock.lock(); defer { lock.unlock() }
        requestMap[key] = object
    }

    func object(for key: String) -> RunningRequest? {
        lock.lock(); defer { lock.unlock() }
        return requestMap[key]
    }
}

private struct RunningRequestCancellable: Cancellable {
    var isCancelled = false
    var onCancel: () -> Void

    init(_ onCancel: @escaping (() -> Void)) {
        self.onCancel = onCancel
    }

    func cancel() {
        onCancel()
    }
}

private extension MoyaProvider {
    class RequestClosureBridge {
        var rawRequestClosure: RequestClosure? {
            didSet {
                injectionRequestClosure = { [weak self] endPoint, closure in
                    self?.rawRequestClosure?(endPoint, { [weak self] result in
                        if case let .success(request) = result, let newRequest = self?.onProcessRequest?(request) {
                            closure(.success(newRequest))
                        } else {
                            closure(result)
                        }
                    })
                }
            }
        }

        var injectionRequestClosure: RequestClosure = { _, _ in }
        var onProcessRequest: ((URLRequest) -> URLRequest)?
    }
}
