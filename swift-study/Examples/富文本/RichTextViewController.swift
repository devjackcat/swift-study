//
//  RichTextViewController.swift
//  swift-study
//
//  Created by 永平 on 2020/7/30.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

class RichTextViewController: UIViewController {

    @IBOutlet var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attrString = NSMutableAttributedString(string: "x 6")
        let attr: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "PingFangSC-Semibold", size: 12),
            .foregroundColor: UIColor(red: 1, green: 0.97, blue: 0.44,alpha:1),
            .strokeColor: UIColor(red: 0.45,green: 0.2,blue: 0.09,alpha: 100),
            .strokeWidth: -6]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        
        
        let layerView = UIView()
        layerView.frame = CGRect(x: 115.5, y: 339, width: 144.5, height: 48)
        // frameFxCode
        let borderLayer = CALayer()
        borderLayer.frame = layerView.bounds
        borderLayer.backgroundColor = UIColor(red: 0.82, green: 0.51, blue: 0.37, alpha: 1).cgColor
        layerView.layer.addSublayer(borderLayer)
        // layerFillCode
        let layer = CALayer()
        layer.frame = CGRect(x: 1.5, y: 1.5, width: 141.5, height: 45)
        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layerView.layer.addSublayer(layer)
        layerView.layer.cornerRadius = 8;
        view.addSubview(layerView)
        
    }
    
}

extension RichTextViewController: StoryboardIdentifiable {
    static var storyboardName: String = "RichTextViewController"
    static var storyboardIdentifier: String = "RichTextViewController"
}
