//
//  UIView+Extension.swift
//  swift-study
//
//  Created by 永平 on 2020/6/30.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

private var leftKey: Void?
private var topKey: Void?
private var rightKey: Void?
private var bottomKey: Void?

@IBDesignable
class IBButton: UIButton {
    
    
    @IBInspectable var enlargeLeft: CGFloat = 0 {
        didSet {
            objc_setAssociatedObject(self, &leftKey, enlargeLeft, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    @IBInspectable var enlargeTop: CGFloat = 0 {
        didSet {
            objc_setAssociatedObject(self, &topKey, enlargeTop, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    @IBInspectable var enlargeRight: CGFloat = 0 {
        didSet {
            objc_setAssociatedObject(self, &rightKey, enlargeRight, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    @IBInspectable var enlargeBottom: CGFloat = 0 {
        didSet {
            objc_setAssociatedObject(self, &bottomKey, enlargeBottom, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    func enlargeEdge(left: CGFloat, top: CGFloat, right: CGFloat, bottom: CGFloat) {
        objc_setAssociatedObject(self, &leftKey, left, .OBJC_ASSOCIATION_ASSIGN)
        objc_setAssociatedObject(self, &topKey, top, .OBJC_ASSOCIATION_ASSIGN)
        objc_setAssociatedObject(self, &rightKey, right, .OBJC_ASSOCIATION_ASSIGN)
        objc_setAssociatedObject(self, &bottomKey, bottom, .OBJC_ASSOCIATION_ASSIGN)
    }

    private func enlargedRect() -> CGRect {
        let topEdge = (objc_getAssociatedObject(self, &topKey) as? CGFloat) ?? 0
        let leftEdge = (objc_getAssociatedObject(self, &leftKey) as? CGFloat) ?? 0
        let rightEdge = (objc_getAssociatedObject(self, &rightKey) as? CGFloat) ?? 0
        let bottomEdge = (objc_getAssociatedObject(self, &bottomKey) as? CGFloat) ?? 0

        return CGRect(x: bounds.origin.x - leftEdge,
                      y: bounds.origin.x - topEdge,
                      width: bounds.size.width + leftEdge + rightEdge,
                      height: bounds.size.height + topEdge + bottomEdge)
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let newRect = enlargedRect()
        return newRect.contains(point) ? self : nil
    }
}
