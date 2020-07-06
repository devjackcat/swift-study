//
//  JCS_BaseVC.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

class JCS_BaseVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        jcs_setup()
    }

    func jcs_setup() {}
    func jcs_bindingSignal() {}
    func jcs_registerNotifications() {}
    func jcs_request() {}
}
