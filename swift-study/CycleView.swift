//
//  CycleView.swift
//  swift-study
//
//  Created by 永平 on 2020/5/25.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

@IBDesignable
class CycleView: UIView {
    enum Sex {
        case Male
        case FeMale
    }

//    @IBInspectable var jackName:String = ""
//    @IBInspectable var age:Int = 0
    @IBInspectable var jcs: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = jcs
        }
    }

//    func siz() {
//        self.layer.cornerRadius = 30
//    }
}
