//
//  UIButton+JCS_Create.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit
import Closures

public extension UIButton {
    // MARK: - 文字

    @discardableResult func jcs_title(_ title: String, state: UIControl.State = .normal) -> Self {
        setTitle(title, for: state)
        return self
    }

    // MARK: - 文字颜色

    @discardableResult func jcs_titleColor(_ color: UIColor, state: UIControl.State = .normal) -> Self {
        setTitleColor(color, for: state)
        return self
    }
    @discardableResult func jcs_titleColor(_ hex: UInt, state: UIControl.State  = .normal ) -> Self {
        setTitleColor(UIColor(hex: hex), for: state)
        return self
    }

    // MAKR: - 字体
    
    @discardableResult func jcs_font(_ font: UIFont) -> Self {
        titleLabel?.font = font
        return self
    }
    @discardableResult func jcs_font(_ fontSize: CGFloat) -> Self {
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    // MARK: - 事件e
    @discardableResult func jcs_onTap(_ action: @escaping ((UIButton)-> Void)) -> Self {
        onTap { [unowned self] in
            action(self)
        }
    }
    // MARK: - 图标
    
    @discardableResult func jcs_image(_ image: UIImage?, state: UIControl.State = .normal) -> Self {
        setImage(image, for: state)
        return self
    }
    @discardableResult func jcs_image(_ imageName: String, state: UIControl.State = .normal) -> Self {
        setImage(UIImage(named: imageName), for: state)
        return self
    }

    // MARK: - 背景图
    
    @discardableResult func jcs_backgroundImage(_ image: UIImage?, state: UIControl.State = .normal) -> Self {
        setBackgroundImage(image, for: state)
        return self
    }
    @discardableResult func jcs_backgroundImage(_ imageName: String, state: UIControl.State = .normal) -> Self {
        setBackgroundImage(UIImage(named: imageName), for: state)
        return self
    }

    // MARK: - adjustsImage
    
    @discardableResult func jcs_adjustsImageWhenHighlighted(_ value: Bool) -> Self {
        adjustsImageWhenHighlighted = value
        return self
    }
    @discardableResult func jcs_adjustsImageWhenDisabled(_ value: Bool) -> Self {
        adjustsImageWhenDisabled = value
        return self
    }

    // MARK: - EdgeInsets
    
    @discardableResult func jcs_imageEdgeInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        imageEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    @discardableResult func jcs_contentEdgeInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        contentEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    @discardableResult func jcs_titleEdgeInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        titleEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
}
