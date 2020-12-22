//
//  RouterConst.swift
//  HJSwift
//
//  Created by PAN on 2017/8/24.
//  Copyright © 2017年 YR. All rights reserved.
//

import Foundation
import Moya

struct RouterConst {
    // 测试服 http://api-uat.tyi365.com/phoenix
    // 预发布 http://api-beta.tyi365.com/phoenix
    // 正式服 https://api.tyi365.com/phoenix
    private(set) static var serverURL = URL(string: ".")!

    #if DEVELOPSERVER
        static var domainPrefix: String = "api-uat" {
            didSet {
                updateServerURL()
            }
        }

        static var domainName: String = "" {
            didSet {
                updateServerURL()
            }
        }

    #else
        static var domainName: String = "" {
            didSet {
                updateServerURL()
            }
        }
    #endif

    static var httpsPort: Int? {
        didSet {
            updateServerURL()
        }
    }

    static var httpPort: Int? {
        didSet {
            updateServerURL()
        }
    }

    static var httpsCerData: Data?
    static var httpsP12Data: Data?
    static var httpsP12Password: String?

    static func dynamicDomainURL(https: Bool = true, prefix: String, path: String? = nil) -> URL {
        var components = URLComponents()
        components.scheme = https ? "https" : "http"
        components.host = "\(prefix).\(domainName)"
        components.port = https ? httpsPort : httpPort
        if let path = path {
            components.path = path.hasPrefix("/") ? path : "/\(path)"
        }
        if let url = components.url {
            return url
        } else {
            fatalError()
        }
    }

    private static func updateServerURL() {
        guard domainName.nilIfEmpty != nil else { return }

        #if DEVELOPSERVER
            serverURL = dynamicDomainURL(https: false, prefix: domainPrefix, path: "phoenix")
        #else
            serverURL = dynamicDomainURL(https: true, prefix: "api", path: "phoenix")
        #endif
    }
}

extension Moya.MultipartFormData {
    init(encrypt params: [String: Any], target: TargetType) {
        let encryptStr = EncryptPlugin.encryptParams(params, target: target)
        let data = encryptStr.data(using: .utf8)
        self.init(provider: .data(data!), name: "data")
    }
}
