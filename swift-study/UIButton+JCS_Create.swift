//
//  UIButton+JCS_Create.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

extension UIButton {
    
    //MARK: - 文字
    func jcs_title(title: String, state: UIControl.State?) -> UIButton {
        self.setTitle(title, for: state ?? .normal)
        return self
    }
    
    //MARK: - 文字颜色
    func jcs_titleColor(color: UIColor, state: UIControl.State?) -> UIButton {
        self.setTitleColor(color, for: state ?? .normal)
        return self
    }
    func jcs_titleColor(hex: Int, state: UIControl.State?) -> UIButton {
        self.setTitleColor(UIColor(hex: hex), for: state ?? .normal)
        return self
    }
    
    //MAKR: - 字体
    func jcs_font(font: UIFont) -> UIButton {
        self.titleLabel?.font = font
        return self
    }
    func jcs_font(fontSize: CGFloat) -> UIButton {
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    
    //MARK: - 图标
    func jcs_image(image: UIImage, state: UIControl.State?) -> UIButton {
        self.setImage(image, for: state ?? .normal)
        return self
    }
    func jcs_image(imageName: String, state: UIControl.State?) -> UIButton {
        self.setImage(UIImage(named: imageName), for: state ?? .normal)
        return self
    }
    
    //MARK: - 背景图
    func jcs_backgroundImage(image: UIImage, state: UIControl.State?) -> UIButton {
        self.setBackgroundImage(image, for: state ?? .normal)
        return self
    }
    func jcs_backgroundImage(imageName: String, state: UIControl.State?) -> UIButton {
        self.setBackgroundImage(UIImage(named: imageName), for: state ?? .normal)
        return self
    }
    
    //MARK: - adjustsImage
    func jcs_adjustsImageWhenHighlighted(value: Bool) -> UIButton {
        self.adjustsImageWhenHighlighted = value
        return self
    }
    func jcs_adjustsImageWhenDisabled(value: Bool) -> UIButton {
        self.adjustsImageWhenDisabled = value
        return self
    }
    
    //MARK: - EdgeInsets
    func jcs_imageEdgeInsets(top:CGFloat,left:CGFloat,bottom:CGFloat,right:CGFloat) -> UIButton {
        self.imageEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    func jcs_contentEdgeInsets(top:CGFloat,left:CGFloat,bottom:CGFloat,right:CGFloat) -> UIButton {
        self.contentEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
}
