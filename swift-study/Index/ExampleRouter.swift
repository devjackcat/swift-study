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
    static func register(navigator: Navigator) {
        
        //        if item.jumpClass == ExampleStackViewVC.self {
        //            return ExampleStackViewVC.instantiateFromStoryboard()
        //        } else if item.jumpClass == IBDesignableKitVC.self {
        //            return IBDesignableKitVC.instantiateFromStoryboard()
        //        } else if item.jumpClass == ExampleRxSwiftVC.self {
        //            return ExampleRxSwiftVC.instantiateFromStoryboard()
        //        } else if item.jumpClass == RichTextViewController.self {
        //            return RichTextViewController.instantiateFromStoryboard()
        //        } else if item.jumpClass == PopverViewController.self {
        //            return PopverViewController.instantiateFromStoryboard()
        //        } else if item.jumpClass == HJGiftPopDemoViewController.self, item.title == "礼物气泡(样式1)" {
        //
        //            JCRouter.handle(url: "jackcat://jumpGiftPopVC/1")
        //
        //        } else if item.jumpClass == HJGiftPopDemoViewController.self, item.title == "礼物气泡(样式2)" {
        //
        //            JCRouter.handle(url: "jackcat://jumpGiftPopVC/2")
        //        } else if item.jumpClass == ModalDemoViewController.self {
        //            return ModalDemoViewController()
        //        } else if item.jumpClass == DemoTouchTroughVC.self {
        //            return DemoTouchTroughVC()
        //        } else if item.jumpClass == CountDownTimerExampleVC.self {
        //            return CountDownTimerExampleVC.instantiateFromStoryboard()
        //        }
        
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
