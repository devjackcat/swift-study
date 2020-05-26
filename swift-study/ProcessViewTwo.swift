//
//  ProcessViewTwo.swift
//  swift-study
//
//  Created by 永平 on 2020/5/25.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit
import SnapKit

class ProcessViewTwo: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        var views = [UIView]()
        
        views.append({
            UIView().jcs_backgroundColor_Random().jcs_layout(superView: self) { (make) in
                make.height.equalTo(50)
            }
        }())
        views.append({
            UIView().jcs_backgroundColor_Random().jcs_layout(superView: self) { (make) in
                make.height.equalTo(80)
            }
        }())
        views.append({
            UIView().jcs_backgroundColor_Random().jcs_layout(superView: self) { (make) in
                make.height.equalTo(30)
            }
        }())
        
//        let stackView = UIStackView(arrangedSubviews: views)
//        stackView.axis = .vertical
//        stackView.alignment = .fill
//        stackView.spacing = 5
//        stackView.distribution = .fill
//        stackView.backgroundColor = UIColor.red
//        self.addSubview(stackView)
//        stackView.snp.makeConstraints { (make) in
//            make.width.equalTo(UIScreen.main.bounds.size.width)
//            make.center.equalTo(self)
//        }
 
        _ = UIStackView(subviews: views,axis: .vertical, distribution: .fill, spacing: 10).jcs_layout(superView: self) { (make) in
            make.width.equalTo(UIScreen.main.bounds.size.width)
            make.center.equalTo(self)
            }.jcs_toStackView().jcs_spacing(20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
