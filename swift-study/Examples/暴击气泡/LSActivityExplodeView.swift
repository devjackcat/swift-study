//
//  LSActivityExplodeView.swift
//  swift-study
//
//  Created by 永平 on 2020/5/29.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

class LSActivityExplodeCellView: UIView {
    var titleLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = UILabel(text: nil, font: UIFont.systemFont(ofSize: 12), color: UIColor.white)
            .jcs_layout(superView: self, layout: { make in
                make.left.top.right.bottom.equalTo(self)
            })
            .jcs_cornerRadius(7)
            .jcs_backgroundColor(.blue)
            .jcs_textAlignment_Center()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LSActivityExplodeView: UIView {
    var cellHeight: CGFloat = 14.0
    var cellSpace: CGFloat = 5.0
    var timer: CADisplayLink!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        clipsToBounds = true
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addItem(item: Int) {
        let newCell = LSActivityExplodeCellView()
        newCell.titleLabel.text = "\(item)"

        if let lastCell = subviews.last, lastCell.frame.origin.y > bounds.size.height - cellHeight { // 最下面一个气泡还没有完全显示,则将新气泡放在最后一个气泡后面
            newCell.frame = CGRect(x: 0.0, y: lastCell.frame.maxY + cellSpace, width: bounds.size.width, height: cellHeight)
        } else { // 最下面一个已经完全显示，则将新气泡放在起点位置
            newCell.frame = CGRect(x: 0.0, y: bounds.size.height + cellSpace, width: bounds.size.width, height: cellHeight)
        }

        addSubview(newCell)

        // 如果就一个元素，则开启计时器
        if subviews.count == 1 {
            start()
        }
    }

    func start() {
        print("开始")
        timer = CADisplayLink(target: self, selector: #selector(ticker(_:)))
        timer.preferredFramesPerSecond = 30
        timer.add(to: RunLoop.main, forMode: .common)
    }

    func stop() {
        timer.invalidate()
    }

    @objc func ticker(_: CADisplayLink) {
        print("ticker \(Date.timeIntervalSinceReferenceDate)")
        subviews.forEach { view in
            var frame = view.frame
            frame.origin.y -= 1
            if frame.origin.y < -cellHeight {
                // 超出界限，改cell失效，做移除处理
                view.removeFromSuperview()
                // 移除时，判断是否当前是否还有subview, 若没有则将定时器停掉
                if self.subviews.count == 0 {
                    stop()
                }
            } else {
                view.frame = frame
                if frame.maxY > self.bounds.maxY { // 没有完全显示，则100
                    view.alpha = 1
                } else {
                    view.alpha = frame.minY / self.bounds.maxY // 其他情况按比例显示alpha
                }
            }
        }
    }
}
