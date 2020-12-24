//
//  OrderVC.swift
//  Order
//
//  Created by 永平 on 2020/12/24.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

import AppFoundation

class OrderVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        IMEngine.shared.addMessageListener(listener: IMListener(receive: { text in
            print("3 号 收到消息 \(text)")
        }))
    }
}
