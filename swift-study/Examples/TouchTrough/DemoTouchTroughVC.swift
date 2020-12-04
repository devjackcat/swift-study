//
//  DemoTouchTroughVC.swift
//  swift-study
//
//  Created by 永平 on 2020/11/6.
//  Copyright © 2020 永平. All rights reserved.
//

import SnapKit
import UIKit
import Closures

class DemoTouchTroughVC: UIViewController {
    var count = 0
    var touchTroughView: ContainerTouchTroughView?
    override func viewDidLoad() {
        view.backgroundColor = .white

        view.addTapGesture { [weak self] _ in
            guard let self = self else { return }
            
            self.count += 1
            print("----click count = \(self.count)")
            if let touchTroughView = self.touchTroughView, self.count == 5 {
                let redView = UIView().jcs_backgroundColor(color: .red)
                    .jcs_userInteractionEnabled(value: true)
                    .jcs_layout(superView: touchTroughView) { make in
                        make.width.equalTo(200)
                        make.height.equalTo(200)
                        make.center.equalTo(touchTroughView)
                    }
                
                redView.addTapGesture { _ in
                    print("---redView")
                }
            }
        }
        
        touchTroughView = ContainerTouchTroughView().jcs_layout(superView: view) { make in
            make.left.top.right.bottom.equalTo(0)
        }
    }
}
