//
//  IBLabel.swift
//  swift-study
//
//  Created by 永平 on 2020/5/25.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

@IBDesignable
class IBLabel: UILabel {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable var bgHexColor: String {
        set {
            self.backgroundColor = UIColor(hex: Int(newValue, radix: 16) ?? 0)
        }
        get {
            return ""
        }
    }
    
    @IBInspectable var textHexColor: String {
        set {
            self.textColor = UIColor(hex: Int(newValue, radix: 16) ?? 0)
        }
        get {
            return ""
        }
    }
}
