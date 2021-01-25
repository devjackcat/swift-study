//
//  JCSNavigatorVC.swift
//  swift-study
//
//  Created by abc on 2021/1/23.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit

var JCSNavigatorTitles: [String] = []

class JCSNavigatorVC: UIViewController {

    weak var navi: JCSNavigationViewController?
    
    deinit {
        print("----JCSNavigatorVC deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JCSNavigatorTitles = [
            "Demo VC 4",
            "Demo VC 3",
            "Demo VC 2",
            "Demo VC 1",
        ]

        view.jcs_backgroundColor(.red)
        
        UIButton().jcs_title("Present")
            .jcs_backgroundColor_Random()
            .jcs_click(closures: { [weak self] sender in
                guard let self = self else { return }
                
                if let navi = self.navi {
                    navi.show()
                } else {
//                    let vc = JCSNavigatorDemoVC(title: "哈哈")
//                    vc.modalPresentationStyle = .fullScreen
//                    self.present(vc, animated: true, completion: nil)
                    
                    let title = JCSNavigatorTitles.popLast()
                    self.navi = JCSNavigationViewController(rootVC: JCSNavigatorDemoVC(title: title!))
//                        .jcs_enterAnimate({ (contentView, completion) in
//                            contentView.alpha = 0.5
//                            UIView.animate(withDuration: 0.25, animations: {
//                                contentView.alpha = 1
//                            }, completion: { _ in
//                                completion()
//                            })
//                        })
//                        .jcs_leaveAnimate({ (contentView, completion) in
//                            UIView.animate(withDuration: 0.25, animations: {
//                                contentView.alpha = 0
//                            }, completion: { _ in
//                                completion()
//                            })
//                        })
                        .jcs_present(hostVC: self, animated: true, completion: {
                            print("--jcs_present completion")
                        })
                }
            })
            .jcs_layout(superView: self) { (make) in
                make.width.equalTo(100)
                make.height.equalTo(50)
                make.centerX.equalToSuperview()
                make.top.equalTo(100)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("------ JCSNavigatorVC viewWillAppear")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("------ JCSNavigatorVC viewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("------ JCSNavigatorVC viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("------ JCSNavigatorVC viewDidDisappear")
    }
    
    // rootVC present JCSNavigatorDemoVC ---------- OK
//    ------ JCSNavigatorVC viewWillDisappear
//    ------ JCSNavigatorDemoVC viewWillAppear
//    ------ JCSNavigatorDemoVC viewDidAppear
//    ------ JCSNavigatorVC viewDidDisappear
    
    // JCSNavigatorDemoVC dismiss
//    ------ JCSNavigatorDemoVC viewWillDisappear
//    ------ JCSNavigatorVC viewWillAppear
//    ------ JCSNavigatorVC viewDidAppear
//    ------ JCSNavigatorDemoVC viewDidDisappear
    
    // Push JCSNavigatorVC
//    ------ Index viewWillDisappear
//    ------ JCSNavigatorVC viewWillAppear
//    ------ Index viewDidDisappear
//    ------ JCSNavigatorVC viewDidAppear
    
    // Pop
//    ------ JCSNavigatorVC viewWillDisappear
//    ------ Index viewWillAppear
//    ------ JCSNavigatorVC viewDidDisappear
//    ------ Index viewDidAppear
}
