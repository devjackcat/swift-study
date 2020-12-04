//
//  ContainerTouchTroughView.swift
//  swift-study
//
//  Created by 永平 on 2020/11/6.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

open class ContainerTouchTroughView: UIView {
    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for view in subviews {
            if view.alpha > 0, !view.isHidden, view.isUserInteractionEnabled, view.point(inside: convert(point, to: view), with: event) {
                return true
            }
        }
        return false
    }
}

open class LayerTouchTroughView: UIView {
    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for view in subviews {
            if view.alpha > 0, !view.isHidden, view.isUserInteractionEnabled, view.layer.presentation()?.frame.contains(point) == true {
                return true
            }
        }
        return false
    }
}
