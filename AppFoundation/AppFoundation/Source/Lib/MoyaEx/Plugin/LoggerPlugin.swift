//
//  LogPlugin.swift
//  HJSwift
//
//  Created by PAN on 2019/10/18.
//  Copyright © 2019 YR. All rights reserved.
//

import Foundation
import Moya
import Result

final class LoggerPlugin: PluginType {
    public func willSend(_ request: RequestType, target: TargetType) {
        var parameters: String?
        if case Moya.Task.requestParameters(parameters: let params, encoding: _) = target.task {
            parameters = params.toJSONSerializationString()
        }
        Log.info("\(target.baseURL.absoluteString)/\(target.path)  \(parameters ?? "")", environmentPrint: false)
    }

    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        var failureResult: Result<Moya.Response, MoyaError>?
        switch result {
        case let .success(response):
            if let map = EncryptPlugin.decryptResponseData(response.data), response.statusCode >= 200, response.statusCode < 300 {
                let code = (map["code"] as? Int) ?? -1
                let errorMessage = map["message"] as? String
                if code != 0 {
                    let error = RouterError(code: code, message: errorMessage)
                    failureResult = .failure(.underlying(error, response))
                }
            } else {
                failureResult = .failure(.underlying(RouterError(code: response.statusCode, message: try? response.mapString()), response))
            }
        case let .failure(error):
            failureResult = .failure(error)
        }
        if let failureResult = failureResult, case let .failure(error) = failureResult {
            var txt = ">>> Router Error <<<"
            txt += "\n    \(target.baseURL)/\(target.path)"
            if case Moya.Task.requestParameters(parameters: let params, encoding: _) = target.task {
                txt += "  \(params.toJSONSerializationString() ?? "") "
            }
            if let e = error.routerError {
                txt += "\n    \(e)\n\n"
            } else {
                txt += "\n    \(error)\n\n"
            }
            Log.error(txt, environmentPrint: false)
        }
    }
}
