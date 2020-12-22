//
//  TargetParameters.swift
//  HJSwift
//
//  Created by PAN on 2019/11/2.
//  Copyright © 2019 YR. All rights reserved.
//

import Foundation
import Moya

extension TargetType {
    var targetToken: String? {
        switch task {
        case .requestParameters(parameters: let params, encoding: _):
            var data = path
            if !params.isEmpty {
                let json = params.zx_sortJsonString()
                data += json
            }
            return data.md5()
        case .requestPlain:
            return "plain"
        default:
            return nil
        }
    }
}

private extension Dictionary {
    func zx_sortJsonString() -> String {
        let tempDic = self as! [String: Any]
        var keys = [String]()
        for key in tempDic.keys {
            keys.append(key)
        }
        keys.sort { $0 < $1 }
        var signString = "{"
        var arr: [String] = []
        for key in keys {
            let value = tempDic[key]
            if let value = value as? [String: Any] {
                arr.append("\"\(key)\":\(value.zx_sortJsonString())")
            } else if let value = value as? [Any] {
                arr.append("\"\(key)\":\(value.zx_sortJsonString())")
            } else {
                arr.append("\"\(key)\":\"\(tempDic[key]!)\"")
            }
        }
        signString += arr.joined(separator: ",")
        signString += "}"
        return signString
    }
}

private extension Array {
    func zx_sortJsonString() -> String {
        let array = self
        var arr: [String] = []
        var signString = "["
        for value in array {
            if let value = value as? [String: Any] {
                arr.append(value.zx_sortJsonString())
            } else if let value = value as? [Any] {
                arr.append(value.zx_sortJsonString())
            } else {
                arr.append("\"\(value)\"")
            }
        }
        arr.sort { $0 < $1 }
        signString += arr.joined(separator: ",")
        signString += "]"
        return signString
    }
}
