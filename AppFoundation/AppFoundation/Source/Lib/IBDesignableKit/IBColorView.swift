//
//  IBColorView.swift
//  HJSwift
//
//  Created by PAN on 2017/8/29.
//  Copyright © 2017年 YR. All rights reserved.
//

import UIKit

@IBDesignable
public class IBColorView: UIView {
    private var imageView: UIImageView = UIImageView()
    private var renderSize: CGSize?

    @IBInspectable var color: UIColor = .white {
        didSet {
            if color != oldValue { updateRadiusColorView() }
        }
    }

    @IBInspectable var bgColorIfBordered: UIColor = .clear {
        didSet {
            if bgColorIfBordered != oldValue { updateRadiusColorView() }
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            if cornerRadius != oldValue { updateRadiusColorView() }
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            if cornerRadius != oldValue { updateRadiusColorView() }
        }
    }

    public override var backgroundColor: UIColor? {
        set {
            super.backgroundColor = .clear
        }
        get {
            return .clear
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        super.backgroundColor = .clear

        updateRadiusColorView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.backgroundColor = .clear

        updateRadiusColorView()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        if imageView.frame != bounds {
            updateRadiusColorView()
        }
    }

    public override func awakeFromNib() {
        updateRadiusColorView()
    }

    private func updateRadiusColorView() {
        super.backgroundColor = .clear
        imageView.frame = bounds

        if borderWidth > 0 {
            if bgColorIfBordered != .clear {
                imageView.image = UIImage.borderImage(withColor: color, backgroundColor: bgColorIfBordered, cornerRadius: cornerRadius, lineWidth: borderWidth)
            } else {
                imageView.image = UIImage.borderImage(withColor: color, cornerRadius: cornerRadius, lineWidth: borderWidth)
            }
        } else if cornerRadius > 0 {
            imageView.image = UIImage.imageAutoResized(withColor: color, cornerRadius: cornerRadius)
        } else {
            imageView.image = UIImage.image(withColor: color, size: CGSize(width: 3, height: 3)).resizableImage(withCapInsets: UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1))
        }
        if imageView.superview == nil {
            insertSubview(imageView, at: 0)
        }
        sendSubviewToBack(imageView)
    }
}
