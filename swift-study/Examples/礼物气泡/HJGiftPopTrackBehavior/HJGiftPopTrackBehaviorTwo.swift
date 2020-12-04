//
//  HJGiftPopTrackBehaviorTwo.swift
//  swift-study
//
//  Created by 永平 on 2020/12/4.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

class HJGiftPopTrackBehaviorTwo: HJGiftPopTrackBehavior {
    
    private let startPointer = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: 250)
    private let endPointer = CGPoint(x: 0, y: UIScreen.main.bounds.size.height)
    
    override func playAnimation() {
        
        guard let viewModel = viewModel else { return }
        
        var i: Double = 0
        viewModel.popViewList.forEach { item in
            i += 1
            delay(0.1 * i) {
                self.startAnimationWithItem(item: item)
            }
        }
    }
    
    private func startAnimationWithItem(item: GiftPopViewItem) {
        item.view.layer.removeAllAnimations()
        
        enterAnim(item: item)
        // 隐藏
        delay(1) {
            self.leaveAnim(item: item)
        }
    }
    
    private func enterAnim(item: GiftPopViewItem) {
        guard let giftVC = giftVC else { return }
        
        let startPointer = giftVC.view.convert(self.startPointer, to: giftVC.parentView)
        let giftCenter = item.view.center
        
        // 显示
        let group = CAAnimationGroup()
        group.isRemovedOnCompletion = false
        group.fillMode = .forwards
        group.repeatCount = 1
        group.duration = 0.25
        
        // 轨迹贝塞尔曲线
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startPointer.x, y: startPointer.y))
        path.addQuadCurve(to: giftCenter, controlPoint: CGPoint(x: giftCenter.x, y: startPointer.y - 150))
        let anim = CAKeyframeAnimation(keyPath: "position")
        anim.path = path.cgPath
        
        // 缩放
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = 0.5
        scaleAnim.toValue = 1
        
        // 透明度
        let opacityAnim = CABasicAnimation(keyPath: "opacity")
        opacityAnim.fromValue = 0
        opacityAnim.toValue = 1
        
        group.animations = [anim,scaleAnim,opacityAnim]
        item.view.layer.add(group, forKey: "anim")
    }
    
    private func leaveAnim(item: GiftPopViewItem) {
        guard let giftVC = giftVC else { return }
        
        let endPointer = giftVC.view.convert(self.endPointer, to: giftVC.parentView)
        let giftCenter = item.view.center
        
        let group = CAAnimationGroup()
        group.isRemovedOnCompletion = false
        group.fillMode = .forwards
        group.repeatCount = 1
        group.duration = 0.25

        // 平移
        let anim = CABasicAnimation(keyPath: "position")
        anim.fromValue = giftCenter
        anim.toValue = CGPoint(x:endPointer.x , y: endPointer.y)

        // 缩放
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = 1
        scaleAnim.toValue = 0.5

        // 透明度
        let opacityAnim = CABasicAnimation(keyPath: "opacity")
        opacityAnim.fromValue = 1
        opacityAnim.toValue = 0

        group.animations = [anim,scaleAnim,opacityAnim]
        item.view.layer.add(group, forKey: "anim")
    }

}
