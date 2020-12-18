//
//  ExampleStackViewVC.swift
//  swift-study
//
//  Created by 永平 on 2020/7/6.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit
import AppFoundation

class ExampleStackViewVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(text: "aa", font: .systemFont(ofSize: 16), color: .black)
            .jcs_layout(superView: self) { (make) in
                make.center.equalTo(self.view)
        }
        
        let font = UIFont.systemFont(ofSize: 12)
        let color = UIColor(hex: 0xEC4B6F)
        let attrString = NSMutableAttributedString(string: "立即进入 >")
        attrString.addAttributes([.font: font,.foregroundColor: color], range: NSRange(location: 0, length: attrString.length))
        attrString.addAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue, .underlineColor: color], range: NSRange(location: 0, length: 4)) // 下划线
        label.attributedText = attrString
    }
}

extension ExampleStackViewVC: StoryboardIdentifiable {
    static var storyboardName: String = "ExampleStackViewVC"
    static var storyboardIdentifier: String = "ExampleStackViewVC"
}
