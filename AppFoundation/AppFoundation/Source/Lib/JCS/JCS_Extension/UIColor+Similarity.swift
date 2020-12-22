//
//  UIColor+Similarity.swift
//  swift-study
//
//  Created by 永平 on 2020/7/7.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

public extension UIColor {
    private func testSimilarity(_ color1: UIColor, _ color2: UIColor, _ tolerance: CGFloat) -> Bool {
        var brightness1: CGFloat = 0
        var saturation1: CGFloat = 0
        var hue1: CGFloat = 0
        var brightness2: CGFloat = 0
        var saturation2: CGFloat = 0
        var hue2: CGFloat = 0

        color1.getHue(&hue1, saturation: &saturation1, brightness: &brightness1, alpha: nil)
        color2.getHue(&hue2, saturation: &saturation2, brightness: &brightness2, alpha: nil)

        if abs(brightness1 - brightness2) < tolerance {
            if brightness1 == 0 {
                return true
            }
            if abs(saturation1 - saturation2) < tolerance {
                if saturation1 == 0 {
                    return true
                }
                if abs(hue1 - hue2) < tolerance * 360 {
                    return true
                }
            }
        }
        return false
    }

    func isSimilarity(to color: UIColor?, tolerance: CGFloat = 0.01) -> Bool {
        guard let color = color else {
            return false
        }
        return testSimilarity(self, color, tolerance)
    }
}
