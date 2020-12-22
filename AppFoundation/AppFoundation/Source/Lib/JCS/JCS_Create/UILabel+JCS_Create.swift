//
//  UILabel+JCS_Create.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import SnapKit
import UIKit

public extension UILabel {
    convenience init(text: String?, font: UIFont, color: UIColor) {
        self.init()
        self.text = text
        self.font = font
        textColor = color
    }

    // MARK: - Text

    func jcs_text(text: String?) -> UILabel {
        self.text = text
        return self
    }

    // MARK: - 颜色

    func jcs_textColor(color: UIColor) -> UILabel {
        textColor = color
        return self
    }

    func jcs_textColor(hex: Int, alpha: CGFloat = 1) -> UILabel {
        textColor = UIColor(hex: hex, alpha: alpha)
        return self
    }

    // MAKR: - 字体
    func jcs_font(font: UIFont) -> UILabel {
        self.font = font
        return self
    }

    func jcs_font(fontSize: CGFloat) -> UILabel {
        font = UIFont.systemFont(ofSize: fontSize)
        return self
    }

    // numberOfLines
    func jcs_numberOfLines(numberOfLines: Int) -> UILabel {
        self.numberOfLines = numberOfLines
        return self
    }

    func jcs_numberOfLines_Zero() -> UILabel {
        numberOfLines = 0
        return self
    }

    // 对齐方式
    func jcs_textAlignment_Left() -> UILabel {
        textAlignment = .left
        return self
    }

    func jcs_textAlignment_Right() -> UILabel {
        textAlignment = .right
        return self
    }

    func jcs_textAlignment_Center() -> UILabel {
        textAlignment = .center
        return self
    }
    
//    @available(iOS 13.0.0, *)
//    @discardableResult
//    func jcs_frame(frame: CGRect) -> some JCS_ReturnAble {
//        super.jcs_frame(frame: frame)
//        return self
//    }
}
