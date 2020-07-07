//
//  ImageWithColor.swift
//  ToWatch
//
//  Created by PANGE on 2017/6/20.
//  Copyright © 2017年 PANGE. All rights reserved.
//

import UIKit

extension UIImage {
    static func image(withColor color: UIColor, size: CGSize = CGSize(width: 1, height: 1), cornerRadius: CGFloat = 0) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        if cornerRadius > 0 {
            let borderPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            borderPath.fill()
        } else {
            context.fill(rect)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }

    static func imageAutoResized(withColor color: UIColor, cornerRadius: CGFloat) -> UIImage {
        let i = cornerRadius + 1
        let s = cornerRadius * 2 + 2
        let size = CGSize(width: s, height: s)
        let insets = UIEdgeInsets(top: i, left: i, bottom: i, right: i)
        let image = self.image(withColor: color, size: size, cornerRadius: cornerRadius)

        return image.resizableImage(withCapInsets: insets, resizingMode: UIImage.ResizingMode.stretch)
    }

    static func borderImage(withColor color: UIColor, cornerRadius: CGFloat, lineWidth: CGFloat) -> UIImage {
        let i = max(cornerRadius + 1, lineWidth + 1)
        let s1 = cornerRadius * 2 + 2
        let s2 = lineWidth * 2 + 2
        let s = max(s1, s2)
        let size = CGSize(width: s, height: s)
        let insets = UIEdgeInsets(top: i, left: i, bottom: i, right: i)

        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        context.setStrokeColor(color.cgColor)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let borderPath = UIBezierPath(roundedRect: rect.insetBy(dx: lineWidth / 2, dy: lineWidth / 2), cornerRadius: cornerRadius)
        borderPath.lineWidth = lineWidth
        borderPath.stroke()
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return image.resizableImage(withCapInsets: insets, resizingMode: UIImage.ResizingMode.stretch)
    }

    static func borderImage(withColor color: UIColor, backgroundColor: UIColor, cornerRadius: CGFloat, lineWidth: CGFloat) -> UIImage {
        let i = max(cornerRadius + 1, lineWidth + 1)
        let s1 = cornerRadius * 2 + 2
        let s2 = lineWidth * 2 + 2
        let s = max(s1, s2)
        let size = CGSize(width: s, height: s)
        let insets = UIEdgeInsets(top: i, left: i, bottom: i, right: i)

        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let borderPath = UIBezierPath(roundedRect: rect.insetBy(dx: lineWidth / 2, dy: lineWidth / 2), cornerRadius: cornerRadius)
        borderPath.lineWidth = lineWidth

        context.setStrokeColor(color.cgColor)
        borderPath.stroke()
        context.setFillColor(backgroundColor.cgColor)
        borderPath.fill()

        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return image.resizableImage(withCapInsets: insets, resizingMode: UIImage.ResizingMode.stretch)
    }

    static func circleImage(withColor color: UIColor, radius: CGFloat) -> UIImage {
        let size = CGSize(width: radius * 2, height: radius * 2)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.addEllipse(in: rect)
        context.fillPath()

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
