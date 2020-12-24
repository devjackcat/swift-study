//
//  IMDemoVC.swift
//  swift-study
//
//  Created by 永平 on 2020/12/24.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

class IMDemoVC: UIViewController {
    override func viewDidLoad() {
        IMEngine.shared.addMessageListener(listener: IMListener(receive: { text in
            print("1 号 收到消息 \(text)")
        }))
        
        IMEngine.shared.addMessageListener(listener: IMListener(receive: { text in
            print("2 号 收到消息 \(text)")
        }))
    }
}
