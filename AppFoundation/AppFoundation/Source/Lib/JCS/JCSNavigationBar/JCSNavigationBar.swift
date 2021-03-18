//
//  JCSNavigationBar.swift
//  swift-study
//
//  Created by 永平 on 2021/3/18.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit

class JCSNavigationBar: UIView {

    var titleLabel: UILabel!
    var backButton: UIButton?
    
    init(title: String, backClosure: (() -> ())? = nil) {
        super.init(frame: .zero)
        
        jcs_backgroundColor_White()
        
        // 标题
        titleLabel = UILabel(text: title, font: .systemFont(ofSize: 18, weight: .semibold), color: UIColor(hex: 0x15161A))
            .jcs_textAlignment_Center()
            .jcs_layout(superView: self, layout: { (make) in
                make.leading.lessThanOrEqualTo(50)
                make.trailing.greaterThanOrEqualTo(-50)
                make.center.equalToSuperview()
            })
        
        if let backClosure = backClosure {
            // 返回按钮
            backButton = UIButton()
                .jcs_image(UIImage(named: "icon_back_grey"))
                .jcs_layout(superView: self, layout: { (make) in
                    make.width.height.equalTo(40)
                    make.centerY.equalToSuperview()
                    make.leading.equalTo(10)
                })
                .jcs_click(closures: { _ in
                    backClosure()
                })
        }
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
