//
//  ViewController.swift
//  swift-study
//
//  Created by 永平 on 2020/5/19.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: JCS_BaseVC {
    
    var label: UILabel!
    
    override func awakeFromNib() {
        
    }

//    @IBAction func sendReqeust(_ sender: Any) {
//        DemoMoya().run()
//    }
    
    override func jcs_setup() {
//          _ = UIControl()
//                    .jcs_layout(superView: self) { (make) in
//                        make.center.equalTo(self.view)
//                        make.width.height.equalTo(200)
//                    }
//                    .jcs_backgroundColor_Random()
//                    .jcs_cornerRadius(value: 100)
//        //            .jcs_tap(closures: { (sender) in
//        //                print("tap \(sender)")
//        //            })
//                    .jcs_toControl()
//                    .jcs_click(closures: { (sender) in
//                        print("click \(sender)")
//                    })
                
        //        _ = UIImageView()
        //            .jcs_layout(superView: self) { (make) in
        //                make.center.equalTo(self.view)
        //                make.width.height.equalTo(200)
        //            }
        //            .jcs_backgroundColor_Random()
        //            .jcs_contentMode(mode: .scaleAspectFit)
        //            .jcs_toImageView().jcs_image(imageUrl: "http://static.devjackcat.com/Fnzn_0JGPGxwUtgvh3i4AsW9Dw8q")
        
//        let xibView =  Bundle.main.loadNibNamed("BottomProcessView", owner: nil, options: nil)?.last as! UIView
//        _ = xibView.jcs_layout(superView: self) { (make) in
//            make.centerY.equalTo(self.view)
//            make.width.equalTo(67)
//            make.height.equalTo(87.5)
//            make.leading.equalTo(20)
//        }
//
//        _ = ProcessViewOne()
//            .jcs_layout(superView: self) { (make) in
//                make.center.equalTo(self.view)
//                make.width.equalTo(67)
//                make.height.equalTo(87.5)
//        }
        
        _ = ProcessViewTwo()
            .jcs_layout(superView: self) { (make) in
//                make.centerY.equalTo(self.view)
//                make.width.equalTo(67)
//                make.height.equalTo(87.5)
//                make.right.equalTo(-20)
                make.top.equalTo(100)
                make.leading.right.bottom.equalTo(0)
        }
        
    }
    
    @IBAction func showIGDemo(_ sender: Any) {
        let vc = IGDemoVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SecondVC {
            vc.title = "This is SecondVC"
        }
    }
}

