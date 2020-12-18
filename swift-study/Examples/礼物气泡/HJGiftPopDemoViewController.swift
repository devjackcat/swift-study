//
//  HJGiftPopDemoViewController.swift
//  swift-study
//
//  Created by 永平 on 2020/8/5.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

import AppFoundation

class HJGiftPopDemoViewController: UIViewController {
    
    typealias GiftPopViewItem = HJGiftPopViewModel.GiftPopViewItem
    typealias Gift = HJGiftPopViewModel.Gift
    typealias SendInfo = HJGiftPopViewModel.SendInfo
    
    // 熊猫主人
    enum PandaMaster {
        case Anchor // 主播
        case Audience // 听众
    }
    
    @IBOutlet var giftPopView1: UIView!
    @IBOutlet var giftPopContentView1: UIView!
    @IBOutlet var giftPopCountLabel1: UILabel!

    @IBOutlet var giftPopView2: UIView!
    @IBOutlet var giftPopContentView2: UIView!
    @IBOutlet var giftPopCountLabel2: UILabel!

    @IBOutlet var giftPopView3: UIView!
    @IBOutlet var giftPopContentView3: UIView!
    @IBOutlet var giftPopCountLabel3: UILabel!

    @IBOutlet var giftPopView4: UIView!
    @IBOutlet var giftPopContentView4: UIView!
    @IBOutlet var giftPopCountLabel4: UILabel!

    @IBOutlet var giftPopView5: UIView!
    @IBOutlet var giftPopContentView5: UIView!
    @IBOutlet var giftPopCountLabel5: UILabel!
    
    @IBOutlet var parentView: UIView!
    
    private var viewModel: HJGiftPopViewModel = HJGiftPopViewModel()
    private var trackBehavior: HJGiftPopTrackBehavior?
    var pandaMaster: PandaMaster = .Anchor

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.popViewList = [
            GiftPopViewItem(isUsing: false, view: giftPopView3, contentView: giftPopContentView3, countLabel: giftPopCountLabel3),
            GiftPopViewItem(isUsing: false, view: giftPopView2, contentView: giftPopContentView2, countLabel: giftPopCountLabel2),
            GiftPopViewItem(isUsing: false, view: giftPopView4, contentView: giftPopContentView4, countLabel: giftPopCountLabel4),
            GiftPopViewItem(isUsing: false, view: giftPopView1, contentView: giftPopContentView1, countLabel: giftPopCountLabel1),
            GiftPopViewItem(isUsing: false, view: giftPopView5, contentView: giftPopContentView5, countLabel: giftPopCountLabel5),
        ]

        viewModel.popViewList.forEach {
            $0.view.alpha = 0
//            $0.contentView.alpha = 0
            viewModel.configCountText(label: $0.countLabel, count: 0)
        }
        

        if pandaMaster == .Anchor {
            trackBehavior = HJGiftPopTrackBehaviorOne(viewModel: viewModel, giftVC: self)
        } else if pandaMaster == .Audience {
            trackBehavior = HJGiftPopTrackBehaviorTwo(viewModel: viewModel, giftVC: self)
        }
    }

    @IBAction func testButtonClick(_: Any) {
        trackBehavior?.playAnimation()
    }
    
}

extension HJGiftPopDemoViewController: StoryboardIdentifiable {
    static var storyboardName: String = "HJGiftPopDemoViewController"
    static var storyboardIdentifier: String = "HJGiftPopDemoViewController"
}
