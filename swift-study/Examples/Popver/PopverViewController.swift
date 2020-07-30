//
//  PopverViewController.swift
//  swift-study
//
//  Created by 永平 on 2020/7/30.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

class PopverViewController: UIViewController {

    var popver: Popover?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showPopver1(_ sender: UIButton) {
        let selector = UIView()
        selector.frame = CGRect(x: 10, y: 10, width: 240, height: 300)
        selector.backgroundColor = UIColor.clear
        
        let backgroundImageView = UIImageView(image: UIImage(named: "切片"))
        backgroundImageView.jcs_layout(superView: selector) { (make) in
            make.edges.equalTo(selector)
        }
        
        let popover = Popover(options: [.type(.auto),.color(UIColor.clear)])
       popover.didDismissHandler = { [weak self] in
           self?.popver = nil
       }
//        popover.blackOverlayColor = UIColor.red
       popover.show(selector, fromView: sender)
       popver = popover
    }
    

}

extension PopverViewController: StoryboardIdentifiable {
    static var storyboardName: String = "PopverViewController"
    static var storyboardIdentifier: String = "PopverViewController"
}
