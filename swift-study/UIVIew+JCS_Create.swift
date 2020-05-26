//
//  UIVIew+JCS_Create.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Closures

extension UIView {
    
    //MARK: - - 布局
    func jcs_layout(superView:AnyObject,layout:(ConstraintMaker) -> Void) -> UIView {
        if let parentView = superView as? UIView {
            parentView.addSubview(self)
        }
        if let parentView = superView as? UIViewController {
            parentView.view.addSubview(self)
        }
        self.snp.makeConstraints(layout)
        return self
    }
    func jcs_layout(superView:AnyObject,frame:CGRect) -> UIView {
        if let parentView = superView as? UIView {
            parentView.addSubview(self)
        }
        if let parentView = superView as? UIViewController {
            parentView.view.addSubview(self)
        }
        self.frame = frame
        return self
    }
    func jcs_frame(frame: CGRect) -> UIView {
        self.frame = frame
        return self
    }
    func jcs_bounds(bounds: CGRect) -> UIView {
        self.bounds = bounds
        return self
    }
    func jcs_center(center: CGPoint) -> UIView {
        self.center = center
        return self
    }
    
    //MARK: - 属性
    func jcs_tag(tag: Int) -> UIView {
        self.tag = tag
        return self
    }
    func jcs_backgroundColor(color: UIColor) -> UIView {
        self.backgroundColor = color
        return self
    }
    func jcs_backgroundColor(hex: Int, alpha: CGFloat = 1) -> UIView {
        self.backgroundColor = UIColor(hex: hex, alpha: alpha)
        return self
    }
    func jcs_backgroundColor_Random() -> UIView {
        self.backgroundColor = UIColor.jcs_randomColor()
        return self
    }
    func jcs_backgroundColor_Clear() -> UIView {
        self.backgroundColor = UIColor.clear
        return self
    }
    func jcs_backgroundColor_White() -> UIView {
        self.backgroundColor = UIColor.white
        return self
    }
    func jcs_contentMode(mode: UIView.ContentMode) -> UIView {
        self.contentMode = mode
        return self
    }
    func jcs_hidden(value: Bool) -> UIView {
        self.isHidden = value
        return self
    }
    func jcs_userInteractionEnabled(value: Bool) -> UIView {
        self.isUserInteractionEnabled = value
        return self
    }
    func jcs_clipsToBounds(value: Bool) -> UIView {
        self.clipsToBounds = value
        return self
    }
    func jcs_alpha(value: CGFloat) -> UIView {
        self.alpha = value
        return self
    }
    
    //MARK: - 显示顺序
    func jcs_bringToFront() -> UIView {
        self.superview?.bringSubviewToFront(self)
        return self
    }
    func jcs_sendToBack() -> UIView {
        self.superview?.sendSubviewToBack(self)
        return self
    }
    
    //MAKR: - CGLayer
    func jcs_cornerRadius(value: CGFloat) -> UIView {
        self.layer.cornerRadius = value
        self.layer.masksToBounds = true
        return self
    }
    func jcs_borderColor(value: UIColor) -> UIView {
        self.layer.borderColor = value.cgColor
        return self
    }
    func jcs_borderColor(hex: Int, alpha: CGFloat = 1) -> UIView {
        self.layer.borderColor = UIColor(hex: hex, alpha: alpha).cgColor
        return self
    }
    func jcs_borderWidth(value: CGFloat) -> UIView {
        self.layer.borderWidth = value
        return self
    }
    
    //MARK: - 事件
    
    func jcs_tap(closures: @escaping (_ sender: UIView) -> Void) -> UIView {
        let tapGesture = UITapGestureRecognizer()
        self.addGestureRecognizer(tapGesture)
        _ = tapGesture.rx.event
            .subscribe(onNext: { [weak self] _ in
            closures(self!)
        })
        return self
    }
    
    //MARK: - 转换
    func jcs_toLabel() -> UILabel {
        return self as! UILabel
    }
    func jcs_toButton() -> UIButton {
        return self as! UIButton
    }
    func jcs_toImageView() -> UIImageView {
        return self as! UIImageView
    }
    func jcs_toControl() -> UIControl {
        return self as! UIControl
    }
    func jcs_toCollectionView() -> UICollectionView {
        return self as! UICollectionView
    }
    func jcs_toTableView() -> UITableView {
        return self as! UITableView
    }
    func jcs_toScrollView() -> UIScrollView {
        return self as! UIScrollView
    }
    func jcs_toStackView() -> UIStackView {
        return self as! UIStackView
    }
//    @property (nonatomic,copy,readonly) UITextField*(^jcs_toTextField)(void);
//    @property (nonatomic,copy,readonly) UITextView*(^jcs_toTextView)(void);
//    @property (nonatomic,copy,readonly) UISegmentedControl*(^jcs_toSegmentedControl)(void);
}
