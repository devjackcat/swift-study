//
//  ProcessViewTwo.swift
//  swift-study
//
//  Created by 永平 on 2020/5/25.
//  Copyright © 2020 永平. All rights reserved.
//

import SnapKit
import UIKit

class ProcessViewTwo: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear

        _ = UIImageView(imageName: "fst_bg")
            .jcs_layout(superView: self) { make in
                make.leading.top.right.bottom.equalTo(0)
            }.jcs_contentMode(mode: .scaleAspectFill)

        let stackView = UIStackView(subviews: nil, spacing: 4.5).jcs_layout(superView: self) { make in
            make.left.equalTo(6)
            make.right.equalTo(-4)
            make.bottom.equalTo(-4)
        }.jcs_toStackView()

        stackView.addArrangedSubview({
            UILabel(text: "距离安全还差:", font: UIFont.systemFont(ofSize: 7), color: UIColor(hex: 0x6B28FF))
                .jcs_layout(superView: self) { make in
                    make.height.equalTo(7)
                }
        }())

        stackView.addArrangedSubview({
            UILabel(text: "距离安全还差:", font: UIFont.systemFont(ofSize: 7), color: UIColor(hex: 0x6B28FF))
                .jcs_layout(superView: self) { make in
                    make.height.equalTo(7)
                }
        }())

        stackView.addArrangedSubview({
            UILabel(text: "距离安全还差:", font: UIFont.systemFont(ofSize: 7), color: UIColor(hex: 0x6B28FF))
                .jcs_layout(superView: self) { make in
                    make.height.equalTo(7)
                }
               }())

        // 进度条背景
        stackView.addArrangedSubview({
            let processBackView = UIView().jcs_layout(superView: self) { make in
                make.height.equalTo(8.5)
            }
            .jcs_backgroundColor(hex: 0xD6C3FF)
            .jcs_cornerRadius(value: 4)

            // 进度条前景色
            _ = UIView().jcs_layout(superView: processBackView) { make in
                make.leading.top.bottom.equalTo(0)
                make.width.equalTo(processBackView).multipliedBy(0.8)
            }
            .jcs_backgroundColor(hex: 0x6C2AFF)
            .jcs_cornerRadius(value: 4)

            // 进度条Label
            _ = UILabel(text: "10/80", font: UIFont.systemFont(ofSize: 7), color: UIColor.white)
                .jcs_layout(superView: processBackView) { make in
                    make.leading.right.top.bottom.equalTo(processBackView)
                }
                .jcs_toLabel().jcs_textAlignment_Center()

            return processBackView
        }())
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
