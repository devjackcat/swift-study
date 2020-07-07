//
//  UIButton+JCS_Create.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

extension UIButton {
    // MARK: - 文字

    func jcs_title(title: String, state: UIControl.State = .normal) -> UIButton {
        setTitle(title, for: state)
        return self
    }

    // MARK: - 文字颜色

    func jcs_titleColor(color: UIColor, state: UIControl.State = .normal) -> UIButton {
        setTitleColor(color, for: state)
        return self
    }

    func jcs_titleColor(hex: Int, state: UIControl.State  = .normal ) -> UIButton {
        setTitleColor(UIColor(hex: hex), for: state)
        return self
    }

    // MAKR: - 字体
    func jcs_font(font: UIFont) -> UIButton {
        titleLabel?.font = font
        return self
    }

    func jcs_font(fontSize: CGFloat) -> UIButton {
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        return self
    }

    // MARK: - 图标

    func jcs_image(image: UIImage, state: UIControl.State = .normal) -> UIButton {
        setImage(image, for: state)
        return self
    }

    func jcs_image(imageName: String, state: UIControl.State = .normal) -> UIButton {
        setImage(UIImage(named: imageName), for: state)
        return self
    }

    // MARK: - 背景图

    func jcs_backgroundImage(image: UIImage, state: UIControl.State = .normal) -> UIButton {
        setBackgroundImage(image, for: state)
        return self
    }

    func jcs_backgroundImage(imageName: String, state: UIControl.State = .normal) -> UIButton {
        setBackgroundImage(UIImage(named: imageName), for: state)
        return self
    }

    // MARK: - adjustsImage

    func jcs_adjustsImageWhenHighlighted(value: Bool) -> UIButton {
        adjustsImageWhenHighlighted = value
        return self
    }

    func jcs_adjustsImageWhenDisabled(value: Bool) -> UIButton {
        adjustsImageWhenDisabled = value
        return self
    }

    // MARK: - EdgeInsets

    func jcs_imageEdgeInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> UIButton {
        imageEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }

    func jcs_contentEdgeInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> UIButton {
        contentEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
}
