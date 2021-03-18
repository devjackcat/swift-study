//
//  LiveVipLevelView.swift
//  swift-study
//
//  Created by 永平 on 2021/3/18.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit

class LiveVipLevelView: UIView {

    private var titleLabel: UILabel!
    var level: Int = 0 {
        didSet {
            titleLabel.text = "Lv\(level)"
            if level > 10 { backgroundColor = UIColor(hex: 0xFFE869) }
            else if level > 8 { backgroundColor = UIColor(hex: 0xFFE13E) }
            else if level > 5 { backgroundColor = UIColor(hex: 0xFF6678) }
            else { backgroundColor = UIColor(hex: 0xEF8CFB) }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = UILabel(text: nil, font: .systemFont(ofSize: 16, weight: .semibold), color: .white)
            .jcs_textAlignment_Center()
            .jcs_layout(superView: self, frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
