//
//  JCSNavigatorDemoVC.swift
//  swift-study
//
//  Created by abc on 2021/1/23.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit

class JCSNavigatorDemoVC: UIViewController {

    private var myTitle = ""
    
    convenience init(title: String) {
        self.init()
        self.myTitle = title
    }
    
    deinit {
        JCSNavigatorTitles.insert(myTitle, at: 0)
        print("--jcs JCSNavigatorDemoVC(\(myTitle) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.jcs_backgroundColor_Random()
        
        UILabel(text: self.myTitle, font: .systemFont(ofSize: 20), color: .red)
            .jcs_layout(superView: self) { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(100)
        }
        
        UIButton().jcs_title("Push")
            .jcs_backgroundColor_Random()
            .jcs_click(closures: { [weak self] sender in
                guard let self = self, let newTitle = JCSNavigatorTitles.popLast() else { return }
                self.jcs_navigator?.push(vc: JCSNavigatorDemoVC(title: newTitle), animated: false)
            })
            .jcs_layout(superView: self) { (make) in
                make.width.equalTo(100)
                make.height.equalTo(50)
                make.centerX.equalToSuperview()
                make.top.equalTo(150)
        }
        
        UIButton().jcs_title("Pop")
            .jcs_backgroundColor_Random()
            .jcs_click(closures: { [weak self] sender in
                guard let self = self else { return }
                self.jcs_navigator?.pop(animated: false)
            })
            .jcs_layout(superView: self) { (make) in
                make.width.equalTo(100)
                make.height.equalTo(50)
                make.centerX.equalToSuperview()
                make.top.equalTo(220)
        }
        
        UIButton().jcs_title("hidden")
            .jcs_backgroundColor_Random()
            .jcs_click(closures: { [weak self] sender in
                guard let self = self else { return }
                self.jcs_navigator?.hidden()
            })
            .jcs_layout(superView: self) { (make) in
                make.width.equalTo(100)
                make.height.equalTo(50)
                make.centerX.equalToSuperview()
                make.top.equalTo(290)
        }
        
        UIButton().jcs_title("pop to root")
            .jcs_backgroundColor_Random()
            .jcs_click(closures: { [weak self] sender in
                guard let self = self else { return }
                self.jcs_navigator?.popToRoot(animated: false)
            })
            .jcs_layout(superView: self) { (make) in
                make.width.equalTo(100)
                make.height.equalTo(50)
                make.centerX.equalToSuperview()
                make.top.equalTo(360)
        }
        
        UIButton().jcs_title("distory")
            .jcs_backgroundColor_Random()
            .jcs_click(closures: { [weak self] sender in
                guard let self = self else { return }
                self.jcs_navigator?.distory(animated: false)
            })
            .jcs_layout(superView: self) { (make) in
                make.width.equalTo(100)
                make.height.equalTo(50)
                make.centerX.equalToSuperview()
                make.top.equalTo(430)
        }
    }
    
}
