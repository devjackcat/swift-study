//
//  UIScrollView+JCS_Create.swift
//  AppFoundation
//
//  Created by 永平 on 2021/1/19.
//

import UIKit

public extension UIScrollView {
    
    @discardableResult func jcs_hideVerticalScrollIndicator() -> Self {
        showsVerticalScrollIndicator = false
        return self
    }
    @discardableResult func jcs_hideHorizontalScrollIndicator() -> Self {
        showsHorizontalScrollIndicator = false
        return self
    }
    @discardableResult func jcs_hideBothScrollIndicator() -> Self {
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        return self
    }
    
    @discardableResult func jcs_delegate(_ delegate: UIScrollViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
    @discardableResult func jcs_contentSize(_ contentSize: CGSize) -> Self {
        self.contentSize = contentSize
        return self
    }
    @discardableResult func jcs_contentInset(_ contentInset: UIEdgeInsets) -> Self {
        self.contentInset = contentInset
        return self
    }
    @discardableResult func jcs_contentOffset(_ contentOffset: CGPoint) -> Self {
        self.contentOffset = contentOffset
        return self
    }
    
    @available(iOS 11.0, *)
    @discardableResult func jcs_contentInsetAdjustmentBehavior_Automatic() -> Self {
        jcs_contentInsetAdjustmentBehavior(.automatic)
        return self
    }
    @available(iOS 11.0, *)
    @discardableResult func jcs_contentInsetAdjustmentBehavior_ScrollableAxes() -> Self {
        jcs_contentInsetAdjustmentBehavior(.scrollableAxes)
        return self
    }
    @available(iOS 11.0, *)
    @discardableResult func jcs_contentInsetAdjustmentBehavior_Never() -> Self {
        jcs_contentInsetAdjustmentBehavior(.never)
        return self
    }
    @available(iOS 11.0, *)
    @discardableResult func jcs_contentInsetAdjustmentBehavior_Always() -> Self {
        jcs_contentInsetAdjustmentBehavior(.always)
        return self
    }
    @available(iOS 11.0, *)
    @discardableResult func jcs_contentInsetAdjustmentBehavior(_ behavior: UIScrollView.ContentInsetAdjustmentBehavior) -> Self {
        self.contentInsetAdjustmentBehavior = behavior;
        return self
    }
    
}
