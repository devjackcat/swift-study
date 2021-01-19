//
//  UIStackView+JCS_Create.swift
//  swift-study
//
//  Created by 永平 on 2020/5/26.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

public extension UIStackView {
    convenience init(subviews: [UIView]? = [UIView](),
                     axis: NSLayoutConstraint.Axis? = .vertical,
                     alignment: UIStackView.Alignment? = .fill,
                     distribution: UIStackView.Distribution? = .fill,
                     spacing: CGFloat? = 0) {
        self.init(arrangedSubviews: subviews ?? [UIView]())
        self.axis = axis ?? .vertical
        self.alignment = alignment ?? .fill
        self.distribution = distribution ?? .fill
        self.spacing = spacing ?? 0
    }

    @discardableResult
    func jcs_axis_Vertical() -> Self {
        axis = .vertical
        return self
    }

    @discardableResult
    func jcs_axis_Horizontal() -> Self {
        axis = .horizontal
        return self
    }

    @discardableResult
    func jcs_alignment(_ alignment: UIStackView.Alignment) -> Self {
        self.alignment = alignment
        return self
    }

    @discardableResult
    func jcs_distribution(_ distribution: UIStackView.Distribution) -> Self {
        self.distribution = distribution
        return self
    }

    @discardableResult
    func jcs_spacing(_ spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }
}
