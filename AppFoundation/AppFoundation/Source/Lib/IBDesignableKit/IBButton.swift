//
//  IBButton.swift
//  HJSwift
//
//  Created by PAN on 2017/8/29.
//  Copyright © 2017年 YR. All rights reserved.
//

import UIKit

@IBDesignable
public class IBButton: UIButton {
    private let shadowLayer = CALayer()

    @IBInspectable var ignoreFixHuohuaColor: Bool = false
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateBackgroundRadiusImage()
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            updateBackgroundRadiusImage()
        }
    }

    @IBInspectable var borderColor: UIColor? {
        didSet {
            updateBackgroundRadiusImage()
        }
    }

    @IBInspectable var gradient: Bool = false {
        didSet {
            updateBackgroundRadiusImage()
        }
    }

    @IBInspectable var gradientLeftColor: UIColor = UIColor(hex: 0xFF435D) {
        didSet {
            updateBackgroundRadiusImage()
        }
    }

    @IBInspectable var gradientRightColor: UIColor = UIColor(hex: 0xFF37B8) {
        didSet {
            updateBackgroundRadiusImage()
        }
    }

    @IBInspectable var gradientVertical: Bool = false {
        didSet {
            updateBackgroundRadiusImage()
        }
    }

    @IBInspectable var gradientLocation: CGFloat = 0.3 {
        didSet {
            updateBackgroundRadiusImage()
        }
    }

    @IBInspectable var gradientShadowColor: UIColor? {
        didSet {
            updateBackgroundRadiusImage()
        }
    }

    @IBInspectable var normalColor: UIColor? {
        didSet {
            updateBackgroundRadiusImage()
        }
    }

    @IBInspectable var selectedColor: UIColor? {
        didSet {
            updateBackgroundRadiusImage()
        }
    }

    @IBInspectable var highlightedColor: UIColor? {
        didSet {
            updateBackgroundRadiusImage()
        }
    }

    @IBInspectable var disabledColor: UIColor? {
        didSet {
            updateBackgroundRadiusImage()
        }
    }

    // 扩大响应区域
    @IBInspectable var enlarge: CGFloat = 0
    
    public override var isSelected: Bool {
        didSet {
            if gradientShadowColor != nil {
                layer.shadowOpacity = !isSelected && isEnabled ? 1 : 0
            }
        }
    }

    public override var isEnabled: Bool {
        didSet {
            if gradientShadowColor != nil {
                layer.shadowOpacity = !isSelected && isEnabled ? 1 : 0
            }
        }
    }

    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let enlargeRect = bounds.insetBy(dx: -enlarge, dy: -enlarge)
        return enlargeRect.contains(point)
    }

    #if !TARGET_INTERFACE_BUILDER
        private var renderSize: CGSize?
    public override func layoutSubviews() {
            super.layoutSubviews()

            var shouldUpdate = renderSize != bounds.size

            if !ignoreFixHuohuaColor {
                /// 将黄色按钮样式强制改为花间样式
                var testColors = [UIColor(hex: 0xFFE100)]
                if #available(iOS 10.0, *) {
                    testColors.append(UIColor(displayP3Hex: 0xFFE100))
                }
                var hitModify = false
                if gradient, testColors.contains(where: { $0.isSimilarity(to: gradientLeftColor) }), testColors.contains(where: { $0.isSimilarity(to: gradientRightColor) }) {
                    hitModify = true
                } else if !gradient, testColors.contains(where: { $0.isSimilarity(to: normalColor) }) {
                    hitModify = true
                }
                if hitModify {
                    gradient = true
                    gradientLeftColor = UIColor(hex: 0xFF435D)
                    gradientRightColor = UIColor(hex: 0xFF37B8)
                    setTitleColor(.white, for: .normal)
                    shouldUpdate = true
                }
            }

            if shouldUpdate {
                renderSize = bounds.size
                updateBackgroundRadiusImage()
            }
        }
    #endif

    private func updateBackgroundRadiusImage() {
        #if !TARGET_INTERFACE_BUILDER
            if renderSize == nil {
                return
            }
        #endif

        guard bounds.size.width > 0, bounds.size.height > 0 else {
            return
        }

        if gradient {
            let left = gradientLeftColor
            let right = gradientRightColor
            let location1 = (gradientLocation > 0 && gradientLocation < 1) ? gradientLocation : 0.5
            let image = UIImage.gradientImage(colors: [left, right], size: bounds.size, locations: [Float(location1), 1], mode: gradientVertical ? .vertical : .horizontal)
            setRadiusBackgroundImage(image, for: .normal)
        } else if let color = normalColor {
            let image = UIImage.image(withColor: color, size: bounds.size)
            setRadiusBackgroundImage(image, for: .normal)
        } else {
            let image = UIImage.image(withColor: .clear, size: bounds.size)
            setRadiusBackgroundImage(image, for: .normal)
        }

        if let shadowColor = gradientShadowColor {
            layer.cornerRadius = cornerRadius
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 5)
            layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), cornerRadius: cornerRadius).cgPath
            layer.shadowOpacity = !isSelected && isEnabled ? 1 : 0
        } else {
            layer.cornerRadius = 0
            layer.shadowColor = UIColor.clear.cgColor
            layer.shadowOffset = .zero
        }

        if let color = selectedColor {
            let image = UIImage.image(withColor: color, size: bounds.size)
            setRadiusBackgroundImage(image, for: .selected)
            // 取消选中时的按钮背景色
            setRadiusBackgroundImage(image, for: [.highlighted, .selected])
        }
        if let color = highlightedColor {
            let image = UIImage.image(withColor: color, size: bounds.size)
            setRadiusBackgroundImage(image, for: .highlighted)
        }
        if let color = disabledColor {
            let image = UIImage.image(withColor: color, size: bounds.size)
            setRadiusBackgroundImage(image, for: .disabled)
        }
    }

    private func setRadiusBackgroundImage(_ image: UIImage?, for state: UIControl.State) {
        var image = image
        if let img = image, cornerRadius > 0 {
            image = Toucan(image: img).maskWithRoundedRect(cornerRadius: CGFloat.minimum(bounds.size.height / 2, cornerRadius),
                                                           borderWidth: borderWidth,
                                                           borderColor: borderColor != nil ? borderColor! : UIColor.white).image
        }
        setBackgroundImage(image, for: state)
    }
}
