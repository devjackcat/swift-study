//
//  UIStackView+JCS_Create.swift
//  swift-study
//
//  Created by 永平 on 2020/5/26.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

extension UIStackView {
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

    func jcs_axis_Vertical() -> UIStackView {
        axis = .vertical
        return self
    }

    func jcs_axis_Horizontal() -> UIStackView {
        axis = .horizontal
        return self
    }

    func jcs_alignment(_ alignment: UIStackView.Alignment) -> UIStackView {
        self.alignment = alignment
        return self
    }

    func jcs_distribution(_ distribution: UIStackView.Distribution) -> UIStackView {
        self.distribution = distribution
        return self
    }

    func jcs_spacing(_ spacing: CGFloat) -> UIStackView {
        self.spacing = spacing
        return self
    }
}
