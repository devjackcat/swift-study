//
//  PageControlDemoVC.swift
//  swift-study
//
//  Created by 永平 on 2021/3/11.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit

class SliderTabControlDemoVC: UIViewController {
    
    private var sliderTab: SliderTabControl?
    
    private var titles = ["首页1","商城1","我的1","首页2","商城2","我的2","首页3","商城3","我的3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.jcs_backgroundColor(UIColor.lightGray)
        
        sliderTab = SliderTabControl().jcs_layout(superView: self) { (make) in
                make.left.right.equalTo(0)
                make.centerY.equalToSuperview()
                make.height.equalTo(50)
            }
            .jcs_numberOfTabs(closures: { [weak self] () -> Int in
                return self?.titles.count ?? 0
            })
            .jcs_titleForTabIndex(closures: { [weak self] (index) -> String in
                return self?.titles[index] ?? ""
            })
            .jcs_itemSelectedClousure(closures: { (index) in
                print("----选择 index = \(index)")
            })
        
        sliderTab?.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titles = ["首页x","商城x","我的x"]
        sliderTab?.reloadData()
    }
    
}
