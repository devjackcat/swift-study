//
//  JCRouter.swift
//  AppFoundation
//
//  Created by 永平 on 2020/12/22.
//

import Foundation
import URLNavigator

public protocol JCRouterProtocol {
    static func register(navigator: Navigator)
    static func handle(navigator: Navigator)
}

public class JCRouter: NSObject {
    private static let navigator = Navigator()
    
    public static func loadRoutes(router: JCRouterProtocol.Type) {
        router.handle(navigator: navigator)
        router.register(navigator: navigator)
    }
    
    public static func route(url: String, content: Any? = nil) {
        if let url = URL(string: url) {
            if let _ = navigator.push(url, context: content) { return }
            if let vc = navigator.present(url, context: content) {
                // 设置返回按钮
                return
            }
            _ = navigator.open(url, context: content)
        }
    }
}

public class XXRouter: JCRouterProtocol {
    public static func register(navigator: Navigator) {
    }
    
    public static func handle(navigator: Navigator) {
    }
}
