//
//  HJGiftPopTrackBehavior.swift
//  swift-study
//
//  Created by 永平 on 2020/12/4.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation

protocol HJGiftPopTrackBehavior {
    init(viewModel: HJGiftPopViewModel, giftVC: HJGiftPopDemoViewController)
    func playAnimation()
}
