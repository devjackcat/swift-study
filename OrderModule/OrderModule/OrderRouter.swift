//
//  OrderRouter.swift
//  Order
//
//  Created by 永平 on 2020/12/24.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit
import URLNavigator
import AppFoundation

public class OrderRouter: JCRouterProtocol {
    public static func register(navigator: Navigator) {
        navigator.register("jackcat://push/order/<string:vc>") { (_, values, _) -> UIViewController? in
            if let vcName = values["vc"] as? String, let cls = NSClassFromString(vcName) as? UIViewController.Type {
                return cls.init()
            }
            return nil
        }
    }
    
    public static func handle(navigator: Navigator) {
        
    }
    

}
