//
//  JCSNotificationVC.swift
//  swift-study
//
//  Created by 永平 on 2021/1/29.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit

class JCSNotificationVC: UIViewController {
    override func viewDidLoad() {
        Notification
            .jcs_addObserver(self, name: "loginNotification1", using: { (notification) in
                 print("  1  object = \(notification.object)  userInfo = \(notification.userInfo)")
             })
            .jcs_addObserver(self, name: "loginNotification2", using: { (notification) in
                print("  2  object = \(notification.object)  userInfo = \(notification.userInfo)")
            })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let userInfo = ["username": "张三"]
        
        Notification
            .jcs_post(name: "loginNotification1", object: self, userInfo: userInfo)
            .jcs_post(name: "loginNotification2", object: self, userInfo: userInfo)
        
    }
}
