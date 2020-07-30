//
//  ColorHex.swift
//  HJSwift
//
//  Created by PAN on 2017/8/29.
//  Copyright © 2017年 YR. All rights reserved.
//

import UIKit

public extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }

    @available(iOS 10.0, *)
    convenience init(displayP3Hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            displayP3Red: CGFloat((displayP3Hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((displayP3Hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(displayP3Hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }

    convenience init(hexString: String) {
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        var rgbValue: UInt32 = 0
//        Scanner(string: cString).scanHexInt32(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: CGFloat(1.0))
    }

    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0

        return String(format: "#%06x", rgb)
    }
}
