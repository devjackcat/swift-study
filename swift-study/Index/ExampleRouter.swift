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
    
    static var bundleName: String {
        let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleName")! as! String
        return name.replacingOccurrences(of: "-", with: "_")
    }
    
    static func register(navigator: Navigator) {
        
        // HJGiftPopDemoViewController
        navigator.register("jackcat://push/HJGiftPopDemoViewController") { (_, _, _) -> UIViewController? in
            return HJGiftPopDemoViewController.instantiateFromStoryboard()
        }
        // ExampleStackViewVC
        navigator.register("jackcat://push/ExampleStackViewVC") { (_, _, _) -> UIViewController? in
            return ExampleStackViewVC.instantiateFromStoryboard()
        }
        // IBDesignableKitVC
        navigator.register("jackcat://push/IBDesignableKitVC") { (_, _, _) -> UIViewController? in
            return IBDesignableKitVC.instantiateFromStoryboard()
        }
        // ExampleRxSwiftVC
        navigator.register("jackcat://push/ExampleRxSwiftVC") { (_, _, _) -> UIViewController? in
            return ExampleRxSwiftVC.instantiateFromStoryboard()
        }
        // RichTextViewController
        navigator.register("jackcat://push/RichTextViewController") { (_, _, _) -> UIViewController? in
            return RichTextViewController.instantiateFromStoryboard()
        }
        // PopverViewController
        navigator.register("jackcat://push/PopverViewController") { (_, _, _) -> UIViewController? in
            return PopverViewController.instantiateFromStoryboard()
        }
        // CountDownTimerExampleVC
        navigator.register("jackcat://push/CountDownTimerExampleVC") { (_, _, _) -> UIViewController? in
            return CountDownTimerExampleVC.instantiateFromStoryboard()
        }
        // ModalDemoViewController
        navigator.register("jackcat://push/ModalDemoViewController") { (_, _, _) -> UIViewController? in
            return ModalDemoViewController()
        }
        // DemoTouchTroughVC
        navigator.register("jackcat://push/DemoTouchTroughVC") { (_, _, _) -> UIViewController? in
            return DemoTouchTroughVC()
        }
        // HJGiftPopDemoViewController
        navigator.register("jackcat://jumpGiftPopVC/<int:id>") { (url, values, context) -> UIViewController? in
            if let id = values["id"] as? Int {
                let vc = HJGiftPopDemoViewController.instantiateFromStoryboard()
                vc.pandaMaster = id == 1 ? .Audience : .Anchor
                return vc
            }
            return UIViewController()
        }
    }
    
    static func handle(navigator: Navigator) {
        navigator.handle("jackcat://toggleTinyConsole") { (url, values, context) -> Bool in
            TinyConsole.toggleWindowMode()
            return true
        }
    }
}
