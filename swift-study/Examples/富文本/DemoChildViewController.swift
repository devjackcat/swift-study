//
//  DemoChildViewController.swift
//  swift-study
//
//  Created by 永平 on 2020/8/5.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

class DemoChildViewController: UIViewController {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UserDefaults.standard.set(true, forKey: "panda_guide")
        if let superView = view.superview {
            superView.removeFromSuperview()
        }
    }

}
