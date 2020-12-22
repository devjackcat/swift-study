//
//  IBProgressView.swift
//  HJSwift
//
//  Created by PAN on 2018/11/22.
//  Copyright © 2018 YR. All rights reserved.
//

import UIKit

@IBDesignable
open class IBProgressView: UIView {
    @IBInspectable open var progress: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable open var progressTintColor: UIColor = .blue {
        didSet {
            progressBar.backgroundColor = progressTintColor
        }
    }

    @IBInspectable open var trackTintColor: UIColor = .clear {
        didSet {
            trackBar.backgroundColor = trackTintColor
        }
    }

    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
            trackBar.layer.cornerRadius = cornerRadius
            trackBar.layer.masksToBounds = cornerRadius > 0
            progressBar.layer.cornerRadius = cornerRadius
            progressBar.layer.masksToBounds = cornerRadius > 0
        }
    }

    private let trackBar = UIView()
    private let progressBar = UIView()

    open func setProgress(_ progress: CGFloat, animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.progress = progress
            }
        } else {
            self.progress = progress
        }
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        clipsToBounds = true
        backgroundColor = .clear

        if trackBar.superview == nil {
            insertSubview(trackBar, at: 0)
        }
        if progressBar.superview == nil {
            insertSubview(progressBar, at: 1)
        }

        if bounds.width > 0, bounds.height > 0 {
            trackBar.frame = bounds

            if progress >= 0 {
                progressBar.frame = CGRect(x: 0, y: 0, width: bounds.width * progress, height: bounds.height)
            }
        }
    }
}
