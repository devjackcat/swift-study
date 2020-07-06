//
//  SecondVC.swift
//  swift-study
//
//  Created by 永平 on 2020/5/25.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        
        let vc = ThirdVC()
        _ = vc.view.jcs_layout(superView: self) { (make) in
            make.width.height.equalTo(100)
            make.center.equalTo(self.view)
        }
        self.addChild(vc)
    }

//    override func performSegue(withIdentifier identifier: String, sender: Any?) {
//
//    }
}
