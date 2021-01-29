//
//  ExampleRouter.swift
//  swift-study
//
//  Created by 永平 on 2020/12/22.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation
import URLNavigator

class ExampleRouter: JCRouterProtocol {
    
    private static func registerSbVC<T: UIViewController>(navigator: Navigator, route: String, cls: T.Type) where T: StoryboardIdentifiable {
        navigator.register(route) { (_, _, context) -> UIViewController? in
            let vc = T.instantiateFromStoryboard()
            if let context = context as? [String: String], let title = context["title"] {
                vc.title = title
            }
            return vc
        }
    }
    
    static func register(navigator: Navigator) {
        registerSbVC(navigator: navigator, route: "jackcat://sb/CountDownTimerExampleVC", cls: CountDownTimerExampleVC.self)
        registerSbVC(navigator: navigator, route: "jackcat://sb/ExampleStackViewVC", cls: ExampleStackViewVC.self)
        registerSbVC(navigator: navigator, route: "jackcat://sb/IBDesignableKitVC", cls: IBDesignableKitVC.self)
        registerSbVC(navigator: navigator, route: "jackcat://sb/ExampleRxSwiftVC", cls: ExampleRxSwiftVC.self)
        registerSbVC(navigator: navigator, route: "jackcat://sb/RichTextViewController", cls: RichTextViewController.self)
        registerSbVC(navigator: navigator, route: "jackcat://sb/PopverViewController", cls: PopverViewController.self)
        registerSbVC(navigator: navigator, route: "jackcat://sb/PushHalfVC", cls: PushHalfVC.self)
        
        
        // HJGiftPopDemoViewController
        navigator.register("jackcat://jumpGiftPopVC/<int:id>") { (url, values, context) -> UIViewController? in
            if let id = values["id"] as? Int {
                let vc = HJGiftPopDemoViewController.instantiateFromStoryboard()
                vc.pandaMaster = id == 1 ? .Audience : .Anchor
                return vc
            }
            return nil
        }
        
        // ModalDemoViewController
        navigator.register("jackcat://runtime/<string:vc>") { (_, values, context) -> UIViewController? in
            if let vcName = values["vc"] as? String,
               let obj = JCSRuntime.createInstance(for: vcName) as? UIViewController {
                if let context = context as? [String: String], let title = context["title"] {
                    obj.title = title
                }
                return obj
            }
            
            return nil
        }
    
    }
    
    static func handle(navigator: Navigator) {
        navigator.handle("jackcat://toggleTinyConsole") { (url, values, context) -> Bool in
            TinyConsole.toggleWindowMode()
            
            let userInfo = ["username": "李四"]
            
            Notification
                .jcs_post(name: "loginNotification1", object: self, userInfo: userInfo)
                .jcs_post(name: "loginNotification2", object: self, userInfo: userInfo)
            
            return true
        }
    }
}
