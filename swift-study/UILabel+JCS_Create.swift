//
//  UILabel+JCS_Create.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit
import SnapKit

extension UILabel {

    convenience init(text:String?,font:UIFont,color:UIColor) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = color
    }
    
    //MARK: - Text
    func jcs_text(text: String?) -> UILabel {
        self.text = text
        return self
    }
    
    //MARK: - 颜色
    func jcs_textColor(color: UIColor) -> UILabel {
        self.textColor = color
        return self
    }
    func jcs_textColor(hex: Int, alpha: CGFloat = 1) -> UILabel {
        self.textColor = UIColor(hex: hex,alpha: alpha)
        return self
    }
    
    //MAKR: - 字体
    func jcs_font(font: UIFont) -> UILabel {
        self.font = font
        return self
    }
    func jcs_font(fontSize: CGFloat) -> UILabel {
        self.font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    //numberOfLines
    func jcs_numberOfLines(numberOfLines: Int) -> UILabel {
        self.numberOfLines = numberOfLines
        return self
    }
    func jcs_numberOfLines_Zero() -> UILabel {
        self.numberOfLines = 0
        return self
    }
    
    //对齐方式
    func jcs_textAlignment_Left() -> UILabel {
        self.textAlignment = .left
        return self
    }
    func jcs_textAlignment_Right() -> UILabel {
        self.textAlignment = .right
        return self
    }
    func jcs_textAlignment_Center() -> UILabel {
        self.textAlignment = .center
        return self
    }
    
}
