//
//  JCDemoView.swift
//  AppFoundation
//
//  Created by 永平 on 2020/12/17.
//

import UIKit
import SnapKit

public class JCDemoView: UIView {
    
    public class func getInstane() -> JCDemoView {
        return JCDemoView.fromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initFromXIB()
    }
    
    private func initFromXIB() {
        let instanceView = JCDemoView.fromNib()
        addSubview(instanceView)
        instanceView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(0)
        }
    }
}
