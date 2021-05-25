//
//  RichXibView.swift
//  swift-study
//
//  Created by 永平 on 2021/5/13.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit

@IBDesignable class RichXibView: UIView {
    
    private(set) var contentView: UIView!
    @IBOutlet var titleLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("----RichXibView.init(coder)")
        
        initFromXIB()
    }
    
    override init(frame: CGRect) {
            
        super.init(frame: frame)
        print("----RichXibView.init(frame)")
        
        initFromXIB()
        
    }
    
    func initFromXIB() {
            
        //nibName是你定义的xib文件名
          let nib = UINib(nibName: "RichXibView", bundle: Bundle(for: type(of: self)))
          contentView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
          contentView.frame = bounds
          self.addSubview(contentView)
            
    }
}
