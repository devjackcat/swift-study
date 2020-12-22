//
//  UIColor+JCS_Extension.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

// 渐变色类型
public enum JCSColorGradientStyle {
    case leftToRight
    case topToBottom
}

public extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let r = (CGFloat)((hex & 0xFF0000) >> 16) / 255.0
        let g = (CGFloat)((hex & 0xFF00) >> 8) / 255.0
        let b = (CGFloat)((hex & 0xFF) >> 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }

    class func jcs_randomColor() -> UIColor {
        let r = (CGFloat)(arc4random() % UInt32(255.0)) / 255.0
        let g = (CGFloat)(arc4random() % UInt32(255.0)) / 255.0
        let b = (CGFloat)(arc4random() % UInt32(255.0)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }

    // 渐变色
    class func jcs_gradientColor(gradientStyle: JCSColorGradientStyle,
                                 size: CGSize,
                                 colors: [UIColor],
                                 locations: [NSNumber]? = [0, 1]) -> UIColor {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(origin: CGPoint.zero, size: size)

        // [UIColor] -> [CGColor]
        var cgcolors = [CGColor]()
        colors.forEach { color in
            cgcolors.append(color.cgColor)
        }
        gradientLayer.colors = cgcolors

        // 渐变方向
        switch gradientStyle {
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        default:
            break
        }

        // 渐变位置
        gradientLayer.locations = locations as [NSNumber]?

        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, UIScreen.main.scale)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if let image = image {
            return UIColor(patternImage: image)
        }
        return UIColor.clear
    }
}
