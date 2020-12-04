//
//  HJGiftPopTrackBehavior.swift
//  swift-study
//
//  Created by 永平 on 2020/12/4.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation

class HJGiftPopTrackBehavior {
 
    typealias GiftPopViewItem = HJGiftPopViewModel.GiftPopViewItem
    typealias Gift = HJGiftPopViewModel.Gift
    typealias SendInfo = HJGiftPopViewModel.SendInfo
    
    weak var giftVC: HJGiftPopDemoViewController?
    weak var viewModel: HJGiftPopViewModel?

    init(viewModel: HJGiftPopViewModel, giftVC: HJGiftPopDemoViewController) {
        self.viewModel = viewModel
        self.giftVC = giftVC
    }
    
    func playAnimation() {}
}
