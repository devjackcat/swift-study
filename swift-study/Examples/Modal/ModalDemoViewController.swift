//
//  ModalDemoViewController.swift
//  swift-study
//
//  Created by 永平 on 2020/8/11.
//  Copyright © 2020 永平. All rights reserved.
//

import RxSwift
import SnapKit
import UIKit

private class ModalVC: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .blue
    }
}

private class ChildVC: UIViewController {
    deinit {
        print(" ChildVC deinit ")
    }
    override func viewDidLoad() {
        view.backgroundColor = .yellow
        
        delay(5) {
//            var vc: UIViewController = self
//            while vc.presentingViewController != nil {
//                vc = vc.presentingViewController!
//            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
//    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
//        let vc = ModalVC()
//        self.showDetailViewController(vc, sender: nil)
//    }
}

class ModalDemoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
//        let vc = ChildVC()
//        view.addSubview(vc.view)
//        vc.view.backgroundColor = .red
//        vc.view.snp.makeConstraints { make in
//            make.leading.top.trailing.bottom.equalTo(0)
//        }
//        addChild(vc)
//
//        delay(10) {
//            vc.view.removeFromSuperview()
//            vc.removeFromParent()
//        }
        
        let vc = ChildVC()
        self.showDetailViewController(vc, sender: nil)
        
        delay(2) {
            let vc = ModalVC()
            self.showDetailViewController(vc, sender: nil)
        }
    }
}
