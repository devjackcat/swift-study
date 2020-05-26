//
//  ProcessViewOne.swift
//  swift-study
//
//  Created by 永平 on 2020/5/25.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

class ProcessViewOne: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        _ = UIImageView(imageName: "fst_bg")
            .jcs_layout(superView: self) { (make) in
                make.leading.top.right.bottom.equalTo(0)
            }.jcs_contentMode(mode: .scaleAspectFill)
        
        //进度条背景
        let processBackView = UIView()
            .jcs_layout(superView: self) { (make) in
                make.leading.equalTo(6)
                make.right.equalTo(-6)
                make.bottom.equalTo(-4)
                make.height.equalTo(8.5)
        }
            .jcs_backgroundColor(hex: 0xD6C3FF)
            .jcs_cornerRadius(value: 4)
        
        //进度条前景色
        let processForeView = UIView()
            .jcs_layout(superView: self) { (make) in
                make.leading.equalTo(6)
                make.bottom.equalTo(-4)
                make.height.equalTo(8.5)
                make.width.equalTo(processBackView).multipliedBy(0.8)
        }
            .jcs_backgroundColor(hex: 0x6C2AFF)
            .jcs_cornerRadius(value: 4)
        
        //进度条Label
        let processLabel = UILabel(text: "10/80", font: UIFont.systemFont(ofSize: 7), color: UIColor.white)
            .jcs_layout(superView: self) { (make) in
                make.leading.right.top.bottom.equalTo(processBackView)
        }
        .jcs_toLabel().jcs_textAlignment_Center()
        
        //距离安全还差
        let safeLabel = UILabel(text: "距离安全还差:", font: UIFont.systemFont(ofSize: 7), color: UIColor(hex: 0x6B28FF))
            .jcs_layout(superView: self) { (make) in
                make.leading.equalTo(6)
                make.right.equalTo(-6)
                make.bottom.equalTo(processBackView.snp.top).offset(-4.5)
        }
        
        //当前排名
        let rankLabel = UILabel(text: "当前排名 No.100", font: UIFont.systemFont(ofSize: 7), color: UIColor(hex: 0x6B28FF))
            .jcs_layout(superView: self) { (make) in
                make.leading.equalTo(6)
                make.right.equalTo(-4)
                make.bottom.equalTo(safeLabel.snp.top).offset(-4.5)
        }
        
        //即将开始Label
        let soonLabel = UILabel(text: "即将开始", font: UIFont.systemFont(ofSize: 7), color: UIColor(hex: 0xFC23FF))
            .jcs_layout(superView: self) { (make) in
                make.leading.equalTo(6)
                make.bottom.equalTo(rankLabel.snp.top).offset(-4.5)
        }
        
        //即将开始TimeLabel
        let soonTimeLabel = UILabel(text: "19:00", font: UIFont.systemFont(ofSize: 7), color: UIColor(hex: 0xFC23FF))
            .jcs_layout(superView: self) { (make) in
                make.right.equalTo(-6)
                make.bottom.equalTo(rankLabel.snp.top).offset(-4.5)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
