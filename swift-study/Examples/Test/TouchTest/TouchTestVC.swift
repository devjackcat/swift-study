//
//  TouchTestVC.swift
//  swift-study
//
//  Created by 永平 on 2021/3/23.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit

private class TestView: UIView {
    private var title: String = ""
    init(_ title: String) {
        super.init(frame: .zero)
        self.title = title
        
        UILabel(text: title, font: .systemFont(ofSize: 12), color: .black)
            .jcs_layout(superView: self) { (make) in
                make.center.equalToSuperview()
            }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print("-------point \(title)")
        return super.point(inside: point, with: event)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("-------hitTest \(title)")
        return super.hitTest(point, with: event)
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("----------touchesEnded \(title)")
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("----------touchesBegan \(title)")
        super.touchesBegan(touches, with: event)
    }
}

class TouchTestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.jcs_backgroundColor_White()
        
        let contentView1 = TestView("contentView1")
            .jcs_backgroundColor(.yellow)
            .jcs_layout(superView: self) { (make) in
                make.top.equalTo(topLayoutGuide.snp.bottom).offset(20)
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.height.equalTo(100)
            }
        
        
        let contentView2 = TestView("contentView2")
            .jcs_backgroundColor(.purple)
            .jcs_layout(superView: self) { (make) in
                make.top.equalTo(contentView1.snp.bottom).offset(20)
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.height.equalTo(300)
            }
        
        let contentView3 = TestView("contentView3")
            .jcs_backgroundColor(.systemPink)
            .jcs_layout(superView: self) { (make) in
                make.bottom.equalTo(bottomLayoutGuide.snp.top).offset(-20)
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.height.equalTo(100)
            }

        TestView("blueView")
            .jcs_backgroundColor(.blue)
            .jcs_layout(superView: contentView2) { (make) in
                make.size.height.equalTo(100)
                make.top.equalTo(20)
                make.right.equalTo(-20)
            }

        let redView = TestView("redView")
            .jcs_backgroundColor(.red)
            .jcs_layout(superView: contentView2) { (make) in
                make.size.height.equalTo(100)
                make.left.top.equalTo(20)
            }

        TestView("greenView")
            .jcs_backgroundColor(.green)
            .jcs_layout(superView: contentView2) { (make) in
                make.size.height.equalTo(100)
                make.top.equalTo(redView.snp.bottom).offset(20)
                make.left.equalTo(redView)
            }
    }
}
