//
//  PushHalfVC.swift
//  swift-study
//
//  Created by 永平 on 2021/1/22.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit

class PushHalfVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.jcs_backgroundColor_Clear()

        UIView().jcs_backgroundColor_Random()
            .jcs_layout(superView: self) { (make) in
                make.width.height.equalTo(200)
                make.center.equalTo(self.view)
            }

        // Do any additional setup after loading the view.
    }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PushHalfVC: StoryboardIdentifiable {
    static var storyboardName: String = "PushHalfVC"
    static var storyboardIdentifier: String = "PushHalfVC"
}
