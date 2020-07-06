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
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var bgHexColor: String {
        set {
            backgroundColor = UIColor(hex: Int(newValue, radix: 16) ?? 0)
        }
        get {
            return ""
        }
    }

    @IBInspectable var textHexColor: String {
        set {
            textColor = UIColor(hex: Int(newValue, radix: 16) ?? 0)
        }
        get {
            return ""
        }
    }
}
