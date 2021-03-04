//
//  JCSDemoVC.swift
//  swift-study
//
//  Created by 永平 on 2021/1/20.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit

class RedView: UIView {
    func changeColor() {
        jcs_backgroundColor_Random()
    }
}

class JCSDemoVC: UIViewController {
    
    var clickBlock: ((RedView) -> Void)?
    
    static var nickname: String = "张三"

    override func viewDidLoad() {
        super.viewDidLoad() 

        view.jcs_backgroundColor_White()
        
        clickBlock = { v in
            v.changeColor()
        }
        
        RedView()
            .jcs_backgroundColor_Random()
            .jcs_click { v in
                self.clickBlock?(v as! RedView)
                 print(Self.nickname)
            }
            .jcs_layout(superView: self) { (make) in
                make.center.equalToSuperview()
                make.width.height.equalTo(200)
            }
    }
    
}
