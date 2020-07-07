//
//  IBCircleProgressView.swift
//  HJSwift
//
//  Created by 刘亚威 on 2019/5/20.
//  Copyright © 2019 YR. All rights reserved.
//

import UIKit

@IBDesignable
class IBCircleProgressView: UIView {
    @IBInspectable open var progressBgColor: UIColor = .clear {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable open var pathColor: UIColor = UIColor.white {
        didSet {
            setNeedsLayout()
        }
    }

    @IBInspectable open var pathWidth: CGFloat = 3 {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }

    @IBInspectable open var clockwise: Bool = true {
        // 默认逆时针
        didSet {
            setNeedsDisplay()
        }
    }

    var isAnimating: Bool = false

    private let startAngle: CGFloat = -CGFloat(Double.pi / 2)
    private let endAngle: CGFloat = CGFloat(Double.pi * 3 / 2)
    private lazy var progressPathLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.frame = bounds
        layer.strokeColor = pathColor.cgColor
        layer.lineWidth = pathWidth
        layer.fillColor = UIColor.clear.cgColor
        layer.lineJoin = .round
        layer.lineCap = .round
        return layer
    }()

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        progressBgColor.set()

        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2),
                                radius: bounds.width / 2 - pathWidth / 2.0,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: clockwise)
        path.lineWidth = pathWidth
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.stroke()
    }

    override func layoutSubviews() {
        if progressPathLayer.superlayer == nil {
            layer.addSublayer(progressPathLayer)
        }

        progressPathLayer.frame = bounds
        progressPathLayer.strokeColor = pathColor.cgColor
        progressPathLayer.lineWidth = pathWidth
        let path = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2),
                                radius: bounds.width / 2 - pathWidth / 2.0,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: clockwise)
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        progressPathLayer.path = path.cgPath
    }

    func setupCircleProgress(leftTime: Int, totalTime: Int) {
        if isAnimating {
            return
        }
        isAnimating = true

        let fromPercent = Double(leftTime) / Double(totalTime)
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = Double(leftTime)
        animation.fromValue = NSNumber(value: fromPercent)
        animation.toValue = NSNumber(value: 0)
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        progressPathLayer.add(animation, forKey: "Progress")

        delay(TimeInterval(totalTime)) { [weak self] in
            self?.isAnimating = false
        }
    }

    func updateCircleProgress(leftTime: Double, totalTime: Double) {
        let fromPercent = (leftTime + 1) / totalTime
        let percent = leftTime / totalTime
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 0.9
        animation.fromValue = NSNumber(value: fromPercent)
        animation.toValue = NSNumber(value: percent)
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        progressPathLayer.add(animation, forKey: "Progress")
    }
}
