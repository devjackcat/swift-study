//
//  HJEncryptPlugin.swift
//  HJSwift
//
//  Created by PAN on 2017/8/24.
//  Copyright © 2017年 YR. All rights reserved.
//

import Alamofire
import Foundation
import Moya
import enum Result.Result

struct EncryptPluginConst {
    static let encryptKey = "spef11kg"
    static let source = "1"

    static var token: String? {
        return UserSession.current.tokenData?.token
    }

    static var uid: String? {
        if let uid = UserSession.current.tokenData?.uid {
            return String(uid)
        }
        return nil
    }
}

final class EncryptPlugin: PluginType {
    private let allowedCharacterSet = CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[] ").inverted

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        // 只加密文本型请求
        if let contentType = request.allHTTPHeaderFields?["Content-Type"] as String?,
            let target = target as? RouterTarget,
            contentType.lowercased().contains("multipart/form-data") == false {
            return encryptRequest(request, target: target)
        }
        return request
    }

    func process(_ result: Result<Moya.Response, MoyaError>, target: TargetType) -> Result<Moya.Response, MoyaError> {
        switch result {
        case let .success(response):
            if let map = EncryptPlugin.decryptResponseData(response.data), response.statusCode >= 200, response.statusCode < 300 {
                let code = (map["code"] as? Int) ?? -1
                let errorMessage = map["message"] as? String
                if code != 0 {
                    let error = RouterError(code: code, message: errorMessage)
                    return .failure(.underlying(error, response))
                } else {
                    var data: Data!
                    if let dataObject = map["data"] {
                        if dataObject is [String: Any] || dataObject is [Any], let jsonData = try? JSONSerialization.data(withJSONObject: dataObject, options: []) {
                            data = jsonData
                        } else if let str = dataObject as? String {
                            data = str.data(using: .utf8)
                        }
                    }
                    if data == nil {
                        data = try? JSONSerialization.data(withJSONObject: [:], options: [])
                    }
                    let processedResponse = Response(statusCode: code, data: data, request: response.request, response: response.response)
                    return .success(processedResponse)
                }
            } else {
                return .failure(.underlying(RouterError(code: response.statusCode, message: nil), response))
            }
        case .failure:
            return .failure(.underlying(RouterError(code: 400, message: nil), nil))
        }
    }

    // 加密URLRequest
    private func encryptRequest(_ request: URLRequest, target: RouterTarget) -> URLRequest {
        var request = request
        let httpMethod = request.httpMethod?.uppercased()
        let params: [String: Any] = target.parameters

        #if DEVELOPSERVER
            let suffix = "&plainText=true"
            var data = EncryptPlugin.trimParams(params, target: target)
        #else
            let suffix = ""
            var data = EncryptPlugin.encryptParams(params, target: target)
        #endif

        data = data.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)!

        if httpMethod == "GET" {
            data = data.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            let url = "\(target.baseURL.absoluteString)/\(target.path)?data=\(data)\(suffix)"
            request.url = URL(string: url)
            request.httpBody = nil
        } else if httpMethod == "POST" {
            request.httpBody = "data=\(data)\(suffix)".data(using: .utf8)
        }

        return request
    }

    // 解密Response.data
    static func decryptResponseData(_ data: Data) -> [String: Any]? {
        if let result = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] {
            return result
        }
        let str = String(data: data, encoding: .utf8)
        if let decrypt = Encrypt.desDecrypt(str, key: EncryptPluginConst.encryptKey), let data = decrypt.data(using: .utf8) {
            let jsonObject = try? JSONSerialization.jsonObject(with: data, options: [])
            if let jsonObject = jsonObject as? [String: Any] {
                return jsonObject
            }
        }
        return nil
    }

    static func encryptParams(_ params: [String: Any], target: TargetType) -> String {
        let jsonString = trimParams(params, target: target)
        let data = Encrypt.desEncrypt(jsonString, key: EncryptPluginConst.encryptKey) as String
        return data
    }

    private static func trimParams(_ params: [String: Any], target: TargetType) -> String {
        var argPath = "arg"
        if let target = target as? RouterTarget {
            argPath = target.argPath
        }

        let query: [String: Any] = ["token": EncryptPluginConst.token ?? "12345678",
                                    "uid": EncryptPluginConst.uid ?? "0",
                                    "version": "\(AppConst.versionCode)",
                                    "source": EncryptPluginConst.source,
                                    "device": AppConst.deviceModel,
                                    "channel": AppConst.channel,
                                    "subChannel": AppConst.subChannel,
                                    "packageName": AppConst.bundleIdentifier,
                                    "network": AppConst.deviceNetworkDesc,
                                    "platform": AppConst.systemVersion,
                                    argPath: params]

        if let json = try? JSONSerialization.data(withJSONObject: query, options: []), let jsonString = String(data: json, encoding: .utf8) {
            return jsonString
        }
        return "{}"
    }
}
