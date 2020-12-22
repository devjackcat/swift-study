//
//  ErrorHandlerPlugin.swift
//  HJSwift
//
//  Created by PAN on 2017/8/24.
//  Copyright © 2017年 YR. All rights reserved.
//

import Foundation
import Moya
import Result

final class ErrorHandlerPlugin: PluginType {
    private var inProcess = false

    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        if inProcess { return result }

        if UserSession.current.tokenData != nil, case let .failure(.underlying(response, _)) = result, let type = response.routerError?.type {
            switch type {
            case .tokenError:
                inProcess = true
                debugPrint("TOKEN失效")

                #if !DEBUG
                    UserSession.logout()
                    NotificationCenter.default.post(name: HJNotification.userLoginKicked)
                #endif

                delay(3) {
                    self.inProcess = false
                }
            case .banned:
                inProcess = true
                NotificationCenter.default.post(name: HJNotification.banned)

                delay(3) {
                    UserSession.logout()
                    NotificationCenter.default.post(name: HJNotification.userLoginKicked)
                    self.inProcess = false
                }
            default:
                break
            }
        }
        return result
    }
}
