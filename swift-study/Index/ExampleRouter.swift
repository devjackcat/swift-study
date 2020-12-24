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
    
    private static func registerSbVC<T: UIViewController>(navigator: Navigator, route: String, cls: T.Type) where T: StoryboardIdentifiable {
        navigator.register(route) { (_, _, _) -> UIViewController? in
            return T.instantiateFromStoryboard()
        }
    }
    
    static func register(navigator: Navigator) {
        registerSbVC(navigator: navigator, route: "jackcat://push/CountDownTimerExampleVC", cls: CountDownTimerExampleVC.self)
        registerSbVC(navigator: navigator, route: "jackcat://push/ExampleStackViewVC", cls: ExampleStackViewVC.self)
        registerSbVC(navigator: navigator, route: "jackcat://push/IBDesignableKitVC", cls: IBDesignableKitVC.self)
        registerSbVC(navigator: navigator, route: "jackcat://push/ExampleRxSwiftVC", cls: ExampleRxSwiftVC.self)
        registerSbVC(navigator: navigator, route: "jackcat://push/RichTextViewController", cls: RichTextViewController.self)
        registerSbVC(navigator: navigator, route: "jackcat://push/PopverViewController", cls: PopverViewController.self)

        // ModalDemoViewController
        navigator.register("jackcat://push/<string:vc>") { (_, values, _) -> UIViewController? in
            if let vcName = values["vc"] as? String, let cls = NSClassFromString(vcName) as? UIViewController.Type {
                return cls.init()
            }
            return nil
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
