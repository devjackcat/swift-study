//
//  UIColor+JCS_Extension.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hex: Int,alpha: CGFloat = 1) {
        let r = ((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0
        let g = ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0
        let b = ((CGFloat)((hex & 0xFF) >> 0)) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    class func jcs_randomColor() -> UIColor {
        let r = (CGFloat)(arc4random() % UInt32(255.0)) / 255.0
        let g = (CGFloat)(arc4random() % UInt32(255.0)) / 255.0
        let b = (CGFloat)(arc4random() % UInt32(255.0)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}
