//
//  TargetApi.swift
//  swift-study
//
//  Created by 永平 on 2020/7/10.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation
import Moya

protocol TargetApi: Moya.TargetType{
    var parameters: [String: Any] { get }
}

extension TargetApi {
    
    var baseURL: URL {
        return ApiConst.baseUrl
    }
    
//    var path: String
    
    var method: Moya.Method {
        return .post
    }
    
    var parameters: [String: Any] {
        return [:]
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [String : String]? {
        return nil
    }
}
