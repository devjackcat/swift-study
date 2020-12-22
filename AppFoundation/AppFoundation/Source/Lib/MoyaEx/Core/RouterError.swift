//
//  RouterError.swift
//  HJSwift
//
//  Created by PAN on 2018/8/7.
//  Copyright © 2018年 YR. All rights reserved.
//

import Foundation
import Moya

public enum RouterErrorType: Int {
    case unknown = 0
    case httpError = 400 // HTTP错误
    case loginUserNotExists = 103 // 登录用户不存在
    case tokenError = 106 // Token失效
    case banned = 119 // 被封号
    case targetBanned = 10031 // 对方被封号
    case NSF = 301 // 扣费余额不足
    case authNeeded = 206 // 需要认证才能使用该功能
    case isBlacked = 506 // 被拉黑
    case follow = 10075 // 关注上限
    case createGroup = 110027 // 创建群组上限
    case joinGroup = 110028 // 加入群组上限
    case notInPickGroup = 315 // 未在挑一挑在线接单状态

    var description: String? {
        switch self {
        case .httpError:
            return "加载慢，请重试"
        case .NSF:
            return "余额不足"
        case .tokenError:
            return "登录状态失效"
        case .authNeeded:
            return "用户未认证"
        case .banned:
            return "被封号"
        default:
            return nil
        }
    }
}

public struct RouterError: Error, LocalizedError {
    var code: Int
    var message: String?
    var type: RouterErrorType

    public init(code: Int, message: String?) {
        self.code = code
        self.message = message
        type = RouterErrorType(rawValue: code) ?? .unknown
    }

    public var errorDescription: String? {
        return localizedDescription
    }

    public var localizedDescription: String {
        return (type.description ?? message) ?? "未知错误 \(code)"
    }
}

extension MoyaError {
    public var localizedDescription: String {
        let desc = errorDescription ?? ""
        return desc.isEmpty ? "加载慢，请重试" : desc
    }
}

extension Swift.Error {
    public var routerError: RouterError? {
        if let e = self as? MoyaError,
            case let MoyaError.underlying(routerError, _) = e {
            return routerError as? RouterError
        }
        if let e = self as? RouterError {
            return e
        }
        return nil
    }
}
