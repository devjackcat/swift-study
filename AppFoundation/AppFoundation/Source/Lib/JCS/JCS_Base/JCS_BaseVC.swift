//
//  JCS_BaseVC.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

open class JCS_BaseVC: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        jcs_setup()
    }

    open func jcs_setup() {}
    open func jcs_bindingSignal() {}
    open func jcs_registerNotifications() {}
    open func jcs_request() {}
}
