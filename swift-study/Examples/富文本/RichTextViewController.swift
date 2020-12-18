//
//  RichTextViewController.swift
//  swift-study
//
//  Created by 永平 on 2020/7/30.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit
import AppFoundation

class RichTextViewController: UIViewController {
    @IBOutlet var label: UILabel!

    @IBOutlet var helloPopView: UIView!
    @IBOutlet var helloPopLabel: UILabel!
    @IBOutlet var helloPopViewWidth: NSLayoutConstraint!
    @IBOutlet var giftCountLabel: UILabel!
    @IBOutlet var giftPopView: UIView!
    @IBOutlet var giftPopContentView: UIView!
    
    @IBOutlet var guideView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
//        // 引导页
//        if UserDefaults.standard.bool(forKey: "panda_guide") {
//            guideView.removeFromSuperview()
//        }
//
//        testPop()
//        testGiftPop()
//
//        let label = UILabel()
//        let attrString = NSMutableAttributedString(string: "527589231")
//        label.frame = CGRect(x: 157.5, y: 581.5, width: 125.5, height: 18)
//        view.addSubview(label)
//        let attr: [NSAttributedString.Key : Any] = [.font: UIFont.boldSystemFont(ofSize: 24),
//                                                    .foregroundColor: UIColor(red: 1, green: 1, blue: 1,alpha:1),
//                                                    .strokeColor: UIColor(red: 0.9,green: 0.54,blue: 0.2,alpha: 100), .strokeWidth: -6]
//        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
//        label.attributedText = attrString
        
    }

//    override func viewDidAppear(_: Bool) {
//        view.backgroundColor = .black
//    }
//
//    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
//        testGiftPopAnim()
//    }

    func testPop() {
        let prizeText = "定海神针(199花瓣)x3"
        let foodText = "金竹子"
        let helloText: NSString = "已追加\(prizeText),\n喂养\(foodText)有概率开出" as NSString

        //        let helloText = "养我，我就会长大，还有\n机会获得奖励喔～"

        // 计算大小
        let maxSize = CGSize(width: 0, height: 30)
        let attribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
        let size = NSString(string: helloText).boundingRect(with: maxSize, options: [.usesLineFragmentOrigin, .usesFontLeading, .truncatesLastVisibleLine], attributes: attribute, context: nil).size
        helloPopViewWidth.constant = size.width + 20

        let attrString = NSMutableAttributedString(string: helloText as String)

        // 深色样式
        attrString.setAttributes([
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor(hex: 0x955A00),
        ], range: NSRange(location: 0, length: helloText.length))

        // 高亮样式
        attrString.setAttributes([
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor(hex: 0x955A00),
        ], range: helloText.range(of: prizeText))
        attrString.setAttributes([
            .font: UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor(hex: 0x955A00),
        ], range: helloText.range(of: foodText))

        helloPopLabel.attributedText = attrString

//        opacity
        helloPopView.isHidden = true
    }

    func testGiftPop() {
        
        let attrString = NSMutableAttributedString(string: "x 6")
        let attr: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 15),
            .foregroundColor: UIColor(red: 1, green: 0.97, blue: 0.44, alpha: 1),
            .strokeColor: UIColor(red: 0.45, green: 0.2, blue: 0.09, alpha: 100),
            .strokeWidth: -6,
        ]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        giftCountLabel.attributedText = attrString
        
        giftPopView.alpha = 0
        
    }

    func testPopAnim() {
        //        helloPopView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        //        UIView.animate(withDuration: 0.25, animations: {
        //            self.helloPopView.alpha = 1
        //            self.helloPopView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        //        }, completion: { _ in
        //            UIView.animate(withDuration: 0.25, animations: {
        //                self.helloPopView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        //            }, completion: { _ in
        //                UIView.animate(withDuration: 0.25, animations: {
        //                    self.helloPopView.transform = CGAffineTransform(scaleX: 1, y: 1)
        //                }, completion: { _ in
        //                    self.helloPopView.transform = CGAffineTransform.identity
        //                })
        //            })
        //        })

        helloPopView.isHidden = false

        let group = CAAnimationGroup()
        group.duration = 0.75

        let basicAnima = CABasicAnimation(keyPath: "opacity")
        basicAnima.fromValue = 0
        basicAnima.toValue = 1
        basicAnima.duration = 0.25
        basicAnima.fillMode = .forwards
        basicAnima.isRemovedOnCompletion = false

        let shakeAnim = CAKeyframeAnimation(keyPath: "transform.scale")
        shakeAnim.values = [CGPoint(x: 0.5, y: 0.5), CGPoint(x: 1.2, y: 1.2), CGPoint(x: 0.8, y: 0.8), CGPoint(x: 1, y: 1)]
        shakeAnim.repeatCount = 1
        shakeAnim.duration = 0.75

        group.animations = [basicAnima, shakeAnim]

        view.layer.add(group, forKey: "Shake")
    }

    func testGiftPopAnim() {
        
        giftPopView.alpha = 1
        giftPopContentView.alpha = 0
        
        UIView.animate(withDuration: 0.25, animations: {
            self.giftPopContentView.alpha = 1
        })
        delay(0.15) {
            let scaleAnim = CAKeyframeAnimation(keyPath: "transform.scale")
            scaleAnim.values = [CGPoint(x: 0.5, y: 0.5), CGPoint(x: 2, y: 2), CGPoint(x: 0.8, y: 0.8), CGPoint(x: 1, y: 1)]
            scaleAnim.repeatCount = 1
            scaleAnim.duration = 0.75
            self.giftCountLabel.layer.add(scaleAnim, forKey: "scaleAnim")
        }
        
        // 向上移动并消失
        delay(1) {
            UIView.animate(withDuration: 1.5, animations: {
                self.giftPopView.transform = CGAffineTransform(translationX: 0, y: -100)
                self.giftPopView.alpha = 0
            }) { _ in
                self.giftPopView.transform = CGAffineTransform.identity
            }
        }
    }

    func testOther() {
        //
        //
        //        let layerView = UIView()
        //        layerView.frame = CGRect(x: 115.5, y: 339, width: 144.5, height: 48)
        //        // frameFxCode
        //        let borderLayer = CALayer()
        //        borderLayer.frame = layerView.bounds
        //        borderLayer.backgroundColor = UIColor(red: 0.82, green: 0.51, blue: 0.37, alpha: 1).cgColor
        //        layerView.layer.addSublayer(borderLayer)
        //        // layerFillCode
        //        let layer = CALayer()
        //        layer.frame = CGRect(x: 1.5, y: 1.5, width: 141.5, height: 45)
        //        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        //        layerView.layer.addSublayer(layer)
        //        layerView.layer.cornerRadius = 8;
        //        view.addSubview(layerView)

        //        let attrString = NSMutableAttributedString(string: "Lv.2")
        //        let shadow = NSShadow()
        //        shadow.shadowColor = UIColor(red:0.54,green:0.3,blue:0.17,alpha:1)
        //        shadow.shadowBlurRadius = 0
        //        shadow.shadowOffset = CGSize(width: 0, height: 1)
        //
        //        let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "PingFangSC-Semibold", size: 14),.foregroundColor: UIColor(red: 0.96, green: 0.96, blue: 1,alpha:1), .shadow: shadow]
        //        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
    }
}

extension RichTextViewController: StoryboardIdentifiable {
    static var storyboardName: String = "RichTextViewController"
    static var storyboardIdentifier: String = "RichTextViewController"
}
