//
//  HJGiftPopTrackBehaviorOne.swift
//  swift-study
//
//  Created by 永平 on 2020/12/4.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

class HJGiftPopTrackBehaviorOne: HJGiftPopTrackBehavior {
    
    override func playAnimation() {
        
        guard let viewModel = viewModel else { return }
        
        var list = [Gift]()
        for i in 0 ..< 12 {
            let gift = Gift(count: i, isTag: false, image: nil)
            list.append(gift)
        }

        viewModel.gifts.append(contentsOf: list)

        if !viewModel.isPlaying {
            viewModel.isPlaying = true
            for i in 0 ..< viewModel.popViewList.count {
                delay(0.2 * Double(i)) { [weak self] in
                    self?.playNextGift()
                }
            }
        }
    }
    
    private func getPopViewItem() -> GiftPopViewItem? {
        guard let viewModel = viewModel else { return nil }
        // 寻找空闲礼物气泡
        return viewModel.popViewList.first(where: { $0.isUsing == false })
    }

    private func startAnimationWithGift(gift: Gift, popViewItem: GiftPopViewItem) {
        
        guard let viewModel = viewModel else { return }
        
        popViewItem.isUsing = true
        viewModel.configCountText(label: popViewItem.countLabel, count: gift.count)

        popViewItem.view.alpha = 1

        UIView.animate(withDuration: 0.25, animations: {
            popViewItem.contentView.alpha = 1
       })
        delay(0.15) {
            let scaleAnim = CAKeyframeAnimation(keyPath: "transform.scale")
            scaleAnim.values = [CGPoint(x: 0.5, y: 0.5), CGPoint(x: 2, y: 2), CGPoint(x: 0.8, y: 0.8), CGPoint(x: 1, y: 1)]
            scaleAnim.repeatCount = 1
            scaleAnim.duration = 0.75
            popViewItem.countLabel.layer.add(scaleAnim, forKey: "scaleAnim")
        }

        // 向上移动并消失
        delay(1) {
            UIView.animate(withDuration: 1.5, animations: {
                popViewItem.view.transform = CGAffineTransform(translationX: 0, y: -100)
                popViewItem.view.alpha = 0
           }) { _ in
                popViewItem.view.transform = CGAffineTransform.identity
                popViewItem.contentView.alpha = 0
                popViewItem.isUsing = false
                // 开始播放下一个礼物
                self.playNextGift()
            }
        }
    }

    private func playNextGift() {
        guard let viewModel = viewModel else { return }
        guard let gift = viewModel.gifts.first else {
            viewModel.isPlaying = false
            return
        }
        viewModel.gifts.removeFirst()
        if let popViewItem = getPopViewItem() {
            startAnimationWithGift(gift: gift, popViewItem: popViewItem)
        }
    }
    
}
