//
//  RouterTarget.swift
//  HJSwift
//
//  Created by PAN on 2017/11/28.
//  Copyright © 2017年 YR. All rights reserved.
//

import Foundation
import Moya

protocol RouterTarget: Moya.TargetType {
    var argPath: String { get }
    var parameters: [String: Any] { get }
}

extension RouterTarget {
    var headers: [String: String]? {
        return nil
    }

    var baseURL: URL {
        return RouterConst.serverURL
    }

    var method: Moya.Method {
        return .post
    }

    var parameterEncoding: Moya.ParameterEncoding {
        return URLEncoding.default
    }

    var sampleData: Data {
        return Data()
    }

    var parameters: [String: Any] {
        return [:]
    }

    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
}
