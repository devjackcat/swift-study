//
//  TouchTestVC.swift
//  swift-study
//
//  Created by 永平 on 2021/3/23.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit

//【原理】iOS事件处理，看我就够了~
//  https://www.imooc.com/article/262290


private class TestButton: UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print("------- TestButton point")
        return super.point(inside: point, with: event)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("------- TestButton hitTest")
        return super.hitTest(point, with: event)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("----------TestButton touchesBegan")
        super.touchesBegan(touches, with: event)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("----------TestButton touchesEnded")
        super.touchesEnded(touches, with: event)
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("----------TestButton touchesCancelled")
        super.touchesCancelled(touches, with: event)
    }
}

private class TestView: UIView, UIGestureRecognizerDelegate {
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
        print("------- TestView point \(title)")
        return super.point(inside: point, with: event)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("------- TestView hitTest \(title)")
        return super.hitTest(point, with: event)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("---------- TestView touchesBegan \(title)")
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("---------- TestView touchesEnded \(title)")
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("---------- TestView touchesCancelled \(title)")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        print("---------- TestView shouldReceive event \(title)")
        return true
    }
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        print("----------shouldReceive touch \(title)")
//        return true
//    }
//    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        print("----------gestureRecognizerShouldBegin \(title)")
//        return true
//    }
}

class TouchTestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.jcs_backgroundColor_White()
        
        var gesture: UITapGestureRecognizer!
        
        
//        gesture = UITapGestureRecognizer { _ in
//            print("------gesture.recognizer view");
//        }
//        view.addGestureRecognizer(gesture)
        
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
        gesture = UITapGestureRecognizer { _ in
            print("------gesture.recognizer contentView2");
        }
        gesture.delegate = contentView2
        contentView2.addGestureRecognizer(gesture)
        
        TestView("contentView3")
            .jcs_backgroundColor(.systemPink)
            .jcs_layout(superView: self) { (make) in
                make.bottom.equalTo(bottomLayoutGuide.snp.top).offset(-20)
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.height.equalTo(100)
            }

        let blueView = TestView("blueView")
            .jcs_backgroundColor(.blue)
            .jcs_layout(superView: contentView2) { (make) in
                make.size.height.equalTo(100)
                make.top.equalTo(20)
                make.right.equalTo(-20)
            }
        gesture = UITapGestureRecognizer { _ in
            print("------gesture.recognizer blueView");
        }
        gesture.delegate = blueView
        blueView.addGestureRecognizer(gesture)

//        let redView = TestView("redView")
//            .jcs_backgroundColor(.red)
//            .jcs_layout(superView: contentView2) { (make) in
//                make.size.height.equalTo(100)
//                make.left.top.equalTo(20)
//            }
//        gesture = UITapGestureRecognizer { _ in
//            print("------gesture.recognizer redView");
//        }
//        gesture.delegate = redView
//        redView.addGestureRecognizer(gesture)
        
        
        let redView = TestButton()
            .jcs_backgroundColor(.red)
            .jcs_layout(superView: contentView2) { (make) in
                make.size.height.equalTo(100)
                make.left.top.equalTo(20)
            }
//            .jcs_onTap { _ in
//                print("--------red Button click")
//            }
//        gesture = UITapGestureRecognizer { _ in
//            print("------gesture.recognizer redView");
//        }
//        redView.addGestureRecognizer(gesture)
        

        TestView("greenView")
            .jcs_backgroundColor(.green)
            .jcs_layout(superView: contentView2) { (make) in
                make.size.height.equalTo(100)
                make.top.equalTo(redView.snp.bottom).offset(20)
                make.left.equalTo(redView)
            }
    }
}
