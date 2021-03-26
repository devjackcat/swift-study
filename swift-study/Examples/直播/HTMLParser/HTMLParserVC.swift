//
//  HTMLParserVC.swift
//  swift-study
//
//  Created by 永平 on 2021/3/24.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit

class HTMLParserVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.jcs_backgroundColor_White()
        
        let label = UILabel()
            .jcs_layout(superView: self) { (make) in
                make.left.equalTo(20)
                make.top.equalTo(topLayoutGuide.snp.bottom).offset(20)
                make.right.bottom.equalTo(-20)
            }
        
        label.text = "xxx"
        
        JCSHtmlParser().parser("")
    }
    
}
