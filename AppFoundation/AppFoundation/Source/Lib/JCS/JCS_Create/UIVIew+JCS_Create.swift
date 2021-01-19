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

    @discardableResult
    func jcs_layout(superView: AnyObject, layout: (ConstraintMaker) -> Void) -> Self {
        if let parentView = superView as? UIView {
            parentView.addSubview(self)
        }
        if let parentView = superView as? UIViewController {
            parentView.view.addSubview(self)
        }
        snp.makeConstraints(layout)
        return self
    }

    @discardableResult
    func jcs_layout(superView: AnyObject, frame: CGRect) -> Self {
        if let parentView = superView as? UIView {
            parentView.addSubview(self)
        }
        if let parentView = superView as? UIViewController {
            parentView.view.addSubview(self)
        }
        self.frame = frame
        return self
    }

    @available(iOS 13.0.0, *)
    @discardableResult
    func jcs_frame(frame: CGRect) -> Self {
        self.frame = frame
        return self
    }

    @discardableResult
    func jcs_bounds(bounds: CGRect) -> Self {
        self.bounds = bounds
        return self
    }

    @discardableResult
    func jcs_center(center: CGPoint) -> Self {
        self.center = center
        return self
    }

    // MARK: - 属性

    @discardableResult
    func jcs_tag(tag: Int) -> Self {
        self.tag = tag
        return self
    }

    @discardableResult
    func jcs_backgroundColor(color: UIColor) -> Self {
        backgroundColor = color
        return self
    }

    @discardableResult
    func jcs_backgroundColor(hex: Int, alpha: CGFloat = 1) -> Self {
        backgroundColor = UIColor(hex: hex, alpha: alpha)
        return self
    }

    @discardableResult
    func jcs_backgroundColor_Random() -> Self {
        backgroundColor = UIColor.jcs_randomColor()
        return self
    }

    @discardableResult
    func jcs_backgroundColor_Clear() -> Self {
        backgroundColor = UIColor.clear
        return self
    }

    @discardableResult
    func jcs_backgroundColor_White() -> Self {
        backgroundColor = UIColor.white
        return self
    }

    @discardableResult
    func jcs_contentMode(mode: UIView.ContentMode) -> Self {
        contentMode = mode
        return self
    }

    @discardableResult
    func jcs_hidden(value: Bool) -> Self {
        isHidden = value
        return self
    }

    @discardableResult
    func jcs_userInteractionEnabled(value: Bool) -> Self {
        isUserInteractionEnabled = value
        return self
    }

    @discardableResult
    func jcs_clipsToBounds(value: Bool) -> Self {
        clipsToBounds = value
        return self
    }

    @discardableResult
    func jcs_alpha(value: CGFloat) -> Self {
        alpha = value
        return self
    }

    // MARK: - 显示顺序

    @discardableResult
    func jcs_bringToFront() -> Self {
        superview?.bringSubviewToFront(self)
        return self
    }

    @discardableResult
    func jcs_sendToBack() -> Self {
        superview?.sendSubviewToBack(self)
        return self
    }

    // MAKR: - CGLayer
    
    @discardableResult
    func jcs_cornerRadius(value: CGFloat) -> Self {
        layer.cornerRadius = value
        layer.masksToBounds = true
        return self
    }

    @discardableResult
    func jcs_borderColor(value: UIColor) -> Self {
        layer.borderColor = value.cgColor
        return self
    }

    @discardableResult
    func jcs_borderColor(hex: Int, alpha: CGFloat = 1) -> Self {
        layer.borderColor = UIColor(hex: hex, alpha: alpha).cgColor
        return self
    }

    @discardableResult
    func jcs_borderWidth(value: CGFloat) -> Self {
        layer.borderWidth = value
        return self
    }

    // MARK: - 事件

    @discardableResult
    func jcs_click(closures: @escaping (_ sender: Self) -> Void) -> Self {
        addTapGesture { [weak self] _ in
            closures(self!)
        }
        return self
    }

    // MARK: - 转换

    @discardableResult
    func jcs_toLabel() -> UILabel {
        return self as! UILabel
    }

    @discardableResult
    func jcs_toButton() -> UIButton {
        return self as! UIButton
    }

    @discardableResult
    func jcs_toImageView() -> UIImageView {
        return self as! UIImageView
    }

    @discardableResult
    func jcs_toControl() -> UIControl {
        return self as! UIControl
    }

    @discardableResult
    func jcs_toCollectionView() -> UICollectionView {
        return self as! UICollectionView
    }

    @discardableResult
    func jcs_toTableView() -> UITableView {
        return self as! UITableView
    }

    @discardableResult
    func jcs_toScrollView() -> UIScrollView {
        return self as! UIScrollView
    }

    @discardableResult
    func jcs_toStackView() -> UIStackView {
        return self as! UIStackView
    }

//    @property (nonatomic,copy,readonly) UITextField*(^jcs_toTextField)(void);
//    @property (nonatomic,copy,readonly) UITextView*(^jcs_toTextView)(void);
//    @property (nonatomic,copy,readonly) UISegmentedControl*(^jcs_toSegmentedControl)(void);
}
