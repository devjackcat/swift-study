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
    @discardableResult func jcs_text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    @discardableResult func jcs_attributedText(_ attrText: NSAttributedString?) -> Self {
        attributedText = attrText
        return self
    }
    // MARK: - 颜色
    @discardableResult func jcs_textColor(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    @discardableResult func jcs_textColor(_ hex: UInt, alpha: CGFloat = 1) -> Self {
        textColor = UIColor(hex: hex, alpha: alpha)
        return self
    }

    // MAKR: - 字体
    @discardableResult func jcs_font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    @discardableResult func jcs_font(_ fontSize: CGFloat) -> Self {
        font = UIFont.systemFont(ofSize: fontSize)
        return self
    }

    // numberOfLines
    @discardableResult func jcs_numberOfLines(_ numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }

    // 对齐方式
    @discardableResult func jcs_textAlignment_Left() -> Self {
        textAlignment = .left
        return self
    }
    @discardableResult func jcs_textAlignment_Right() -> Self {
        textAlignment = .right
        return self
    }
    @discardableResult func jcs_textAlignment_Center() -> Self {
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
