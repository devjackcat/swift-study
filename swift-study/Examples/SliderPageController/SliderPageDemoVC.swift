//
//  SliderPageDemoVC.swift
//  swift-study
//
//  Created by 永平 on 2021/3/12.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit

class SliderPageDemoVC: SliderPageViewController {

    var titles = ["视频聊","派对","三星","五星"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titles = ["视频聊","派对","三星","五星","流行"]
        reloadData()
    }
    
    override func sliderTabTop() -> CGFloat {
        return 64
    }
    override func sliderPageCount() -> Int {
        return titles.count
    }
    override func sliderPageTitle(for index: Int) -> String {
        return titles[index]
    }
    override func sliderPageViewController(for index: Int) -> UIViewController {
        let vc = UIViewController()
        vc.view.jcs_backgroundColor_Random()
        return vc
    }
}
