//
//  IGDemoCell1.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

class IGDemoCell1: UICollectionViewCell {
    var titleLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)

        titleLabel = UILabel(text: nil, font: UIFont.systemFont(ofSize: 16), color: UIColor.red)
            .jcs_layout(superView: contentView, layout: { make in
                make.center.equalTo(self.contentView)
            })
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configData(data: String) {
        titleLabel.text = data
    }
}
