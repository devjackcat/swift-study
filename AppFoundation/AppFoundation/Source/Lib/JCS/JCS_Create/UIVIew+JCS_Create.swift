//
//  UIVIew+JCS_Create.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import Closures
import SnapKit
import UIKit

public extension UIView {
    // MARK: - - 布局
    private func jcs_layout(superView: AnyObject) {
        if let parentView = superView as? UIStackView {
            parentView.addArrangedSubview(self)
        } else if let parentView = superView as? UIView {
            parentView.addSubview(self)
        } else if let parentView = superView as? UIViewController {
            parentView.view.addSubview(self)
        }
    }
    @discardableResult func jcs_layout(superView: AnyObject, layout: (ConstraintMaker) -> Void) -> Self {
        jcs_layout(superView: superView)
        snp.makeConstraints(layout)
        return self
    }
    @discardableResult func jcs_layout(superView: AnyObject, frame: CGRect) -> Self {
        jcs_layout(superView: superView)
        self.frame = frame
        return self
    }
    @discardableResult func jcs_frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    @discardableResult func jcs_bounds(_ bounds: CGRect) -> Self {
        self.bounds = bounds
        return self
    }
    @discardableResult func jcs_center(_ center: CGPoint) -> Self {
        self.center = center
        return self
    }

    // MARK: - 属性

    @discardableResult func jcs_tag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }
    @discardableResult func jcs_backgroundColor(_ color: UIColor) -> Self {
        backgroundColor = color
        return self
    }
    @discardableResult func jcs_backgroundColor(_ hex: UInt, alpha: CGFloat = 1) -> Self {
        backgroundColor = UIColor(hex: hex, alpha: alpha)
        return self
    }
    @discardableResult func jcs_backgroundColor_Random() -> Self {
        backgroundColor = UIColor.jcs_randomColor()
        return self
    }
    @discardableResult func jcs_backgroundColor_Clear() -> Self {
        backgroundColor = UIColor.clear
        return self
    }
    @discardableResult func jcs_backgroundColor_White() -> Self {
        backgroundColor = UIColor.white
        return self
    }
    @discardableResult func jcs_contentMode(_ mode: UIView.ContentMode) -> Self {
        contentMode = mode
        return self
    }
    @discardableResult func jcs_hidden(_ hidden: Bool) -> Self {
        isHidden = hidden
        return self
    }
    @discardableResult func jcs_userInteractionEnabled(_ enabled: Bool) -> Self {
        isUserInteractionEnabled = enabled
        return self
    }
    @discardableResult func jcs_clipsToBounds(_ value: Bool) -> Self {
        clipsToBounds = value
        return self
    }
    @discardableResult func jcs_alpha(_ alpha: CGFloat) -> Self {
        self.alpha = alpha
        return self
    }

    // MARK: - 显示顺序
    
    @discardableResult func jcs_bringToFront() -> Self {
        superview?.bringSubviewToFront(self)
        return self
    }
    @discardableResult func jcs_sendToBack() -> Self {
        superview?.sendSubviewToBack(self)
        return self
    }

    // MAKR: - CGLayer
    
    @discardableResult func jcs_cornerRadius(_ radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        return self
    }
    @discardableResult func jcs_borderColor(_ color: UIColor) -> Self {
        layer.borderColor = color.cgColor
        return self
    }
    @discardableResult func jcs_borderColor(_ hex: UInt, alpha: CGFloat = 1) -> Self {
        layer.borderColor = UIColor(hex: hex, alpha: alpha).cgColor
        return self
    }
    @discardableResult func jcs_borderWidth(_ width: CGFloat) -> Self {
        layer.borderWidth = width
        return self
    }
    @discardableResult func jcs_shadowColor(_ color: UIColor) -> Self {
        layer.shadowColor = color.cgColor
        return self
    }
    @discardableResult func jcs_shadowPath(_ path: UIBezierPath) -> Self {
        layer.shadowPath = path.cgPath
        return self
    }
    @discardableResult func jcs_shadowOffset(_ offset: CGSize) -> Self {
        layer.shadowOffset = offset
        return self
    }
    @discardableResult func jcs_shadowRadius(_ radius: CGFloat) -> Self {
        layer.shadowRadius = radius
        return self
    }
    @discardableResult func jcs_shadowOpacity(_ opacity: Float) -> Self {
        layer.shadowOpacity = opacity
        return self
    }

    // MARK: - 事件

    @discardableResult func jcs_click(closures: @escaping (_ sender: Self) -> Void) -> Self {
        isUserInteractionEnabled = true
        addTapGesture { [weak self] _ in
            closures(self!)
        }
        return self
    }

}
