//
//  LazyProvider.swift
//  swift-study
//
//  Created by 永平 on 2020/7/10.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class LazyProvider<Target: TargetType>: MoyaCacheableProvider<Target> {
    override init(policy: MoyaCacheableProviderPolicy, cacheMaxAge: UInt, endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping, requestClosure: @escaping RequestClosure = MoyaProvider<Target>.defaultRequestMapping, stubClosure: @escaping StubClosure = MoyaProvider.neverStub, callbackQueue: DispatchQueue? = nil, manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(), plugins: [PluginType] = [], trackInflights: Bool = false) {
        super.init(policy: policy, cacheMaxAge: cacheMaxAge, endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, callbackQueue: callbackQueue, manager: manager, plugins: plugins, trackInflights: trackInflights)
        LazyProviderRunningPool.shared.makeAlive(self)
    }

    @discardableResult
    open func request(_ target: Target,
                      callbackQueue: DispatchQueue? = .none) -> Cancellable {
        return request(target, callbackQueue: callbackQueue, progress: nil, completion: { _ in })
    }

    @discardableResult
    override func request(_ target: Target,
                          callbackQueue: DispatchQueue? = .none,
                          progress: ProgressBlock? = .none,
                          completion: @escaping Completion) -> Cancellable {
        let injectedCompletion: Completion = { [weak self] result in
            completion(result)
            if let self = self {
                LazyProviderRunningPool.shared.removeAlive(self)
            }
        }
        return super.request(target, callbackQueue: callbackQueue, progress: progress, completion: injectedCompletion)
    }
}

private class LazyProviderRunningPool {
    static let shared = LazyProviderRunningPool()
    private var holder = [AnyObject]()
    private let lock = NSLock()

    func makeAlive<T>(_ provier: LazyProvider<T>) {
        lock.lock(); defer { lock.unlock() }
        let obj = provier as AnyObject
        holder.append(obj)
    }

    func removeAlive<T>(_ provier: LazyProvider<T>) {
        lock.lock(); defer { lock.unlock() }
        let obj = provier as AnyObject
        holder.removeAll(where: { $0 === obj })
    }
}

private class RouterSessionManager: SessionManager {
    override func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        let request = super.request(urlRequest)
        request.delegate.queue.qualityOfService = .userInitiated
        request.task?.priority = URLSessionTask.highPriority
        return request
    }
}

let LazyProviderUrlCache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: "LazyProvider")

private let routerSharedSessionManager: SessionManager = {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
    configuration.timeoutIntervalForRequest = 15 // as seconds, you can set your request timeout
    configuration.timeoutIntervalForResource = 120 // as seconds, you can set your resource timeout
    configuration.requestCachePolicy = .useProtocolCachePolicy
    configuration.httpMaximumConnectionsPerHost = 10
    configuration.urlCache = LazyProviderUrlCache

    let manager = RouterSessionManager(configuration: configuration)
    manager.bindHttpsSessionChallenge()
    manager.startRequestsImmediately = false
    return manager
}()

extension TargetApi {
    static func lazyProvider(cacheMaxAge: UInt = 1800) -> LazyProvider<Self> {
        return provider(mode: .lazy, cacheMaxAge: cacheMaxAge)
    }

    static func provider(mode: LazyProviderMode = .normal, cacheMaxAge: UInt = 1800) -> LazyProvider<Self> {
        return LazyProvider<Self>(policy: mode.policy,
                                  cacheMaxAge: cacheMaxAge,
                                  manager: routerSharedSessionManager,
                                  plugins: [LoggerPlugin(),
                                            EncryptPlugin(),
                                            ErrorHandlerPlugin(),
                                            NetworkActivityPlugin { _, _ in }])
    }
}

enum LazyProviderMode: Int {
    /// 有多个相同的请求同时进行，会合并
    case normal

    /// 有多个相同的请求同时进行，也不会合并
    case always

    /// 有缓存时会读取缓存，没有缓存时同normal
    case lazy

    fileprivate var policy: MoyaCacheableProviderPolicy {
        switch self {
        case .normal:
            return .reloadMergeConcurrent
        case .lazy:
            return .returnCacheElseLoad
        case .always:
            return .reload
        }
    }
}

