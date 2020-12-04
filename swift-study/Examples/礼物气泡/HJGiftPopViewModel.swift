//
//  HJGiftPopViewModel.swift
//  swift-study
//
//  Created by 永平 on 2020/12/4.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

class HJGiftPopViewModel {

    struct Gift {
        var count: Int
        var isTag: Bool
        var image: String?
    }

    struct SendInfo {
        var gifts: [Gift] = []
    }

    class GiftPopViewItem {
        var isUsing = false
        var view: UIView!
        var contentView: UIView!
        var countLabel: UILabel!
        var bgImageView: UIImageView?
        var giftImageView: UIImageView?

        convenience init(isUsing: Bool,
                         view: UIView,
                         contentView: UIView,
                         countLabel: UILabel,
                         bgImageView _: UIImageView? = nil,
                         giftImageView: UIImageView? = nil) {
            self.init()

            self.isUsing = isUsing
            self.view = view
            self.contentView = contentView
            self.countLabel = countLabel
            self.giftImageView = giftImageView
        }
    }
    
    var isPlaying = false
    var gifts: [Gift] = []
    
    var popViewList: [GiftPopViewItem] = []
    
    // 设置礼物数量富文本
    func configCountText(label: UILabel, count: Int) {
        let attrString = NSMutableAttributedString(string: "x \(count)")
        let attr: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 15),
            .foregroundColor: UIColor(red: 1, green: 0.97, blue: 0.44, alpha: 1),
            .strokeColor: UIColor(red: 0.45, green: 0.2, blue: 0.09, alpha: 100),
            .strokeWidth: -6,
        ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
    }

}
