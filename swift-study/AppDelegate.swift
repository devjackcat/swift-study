//
//  AppDelegate.swift
//  swift-study
//
//  Created by 永平 on 2020/5/19.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

import HandyJSON
import OrderModule

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ViewController.instantiateFromStoryboard()
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        // 加载路由
        loadRoutes()
        // 注册三方库
        registerThirdParty()
        
//        test()
        
        return true
    }
    
    private func loadRoutes() {
        JCRouter.loadRoutes(router: XXRouter.self)
        JCRouter.loadRoutes(router: ExampleRouter.self)
        JCRouter.loadRoutes(router: OrderRouter.self)
    }
    
    private func registerThirdParty() {
        IMEngine.shared.register(appKey: "848e7084284a6c8374182ced5a0604a3")
        IMEngine.shared.login(account: "jackcat", token: "jackcat-token")
    }
    
//    func test() {
//
//        nimdemo.test()
//
//        let data: [String : Any] = [
//            "msgType":1001,
//            "subType":100101,
//            "msgJson": [
//                "username": "Jack",
//                "nickname": "Jack猫",
//                "age": 22
//            ]
//        ]
//        let attachment = IMAttachment<PersonVO>(data: data)
//        if let vo = attachment.wrapper.vo {
//            print(vo.username)
//        }
//    }
}
