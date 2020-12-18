//
//  CountDownTimerExampleVC.swift
//  swift-study
//
//  Created by 永平 on 2020/12/11.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

import AppFoundation

class CountDownTimerExampleVC: UIViewController {
    
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var processLabel: UILabel!
    
    private var timer: CountDownTimer!
    
    // 倒计时30s
    let duration: TimeInterval = 30
    
    override func viewDidLoad() {
        timer = CountDownTimer(total: duration, repeat: 1) { [weak self] (timer, interval) in
            self?.statusLabel.text = "进行中"
            self?.processLabel.text = ""
        } handler: { [weak self]  (timer, interval) in
            guard let self = self else { return }
            self.processLabel.text = "总时长\(self.duration)s, 当前\(Int(interval))s"
        } timeOut: { [weak self]  (timer, interval) in
            self?.statusLabel.text = ""
            self?.processLabel.text = ""
        }
        
//        let v = JCDemoView.fromNib()
//        view.addSubview(v)
//        v.snp.makeConstraints { (make) in
//            make.center.equalTo(self.view)
//            make.width.height.equalTo(200)
//        }
    }
        
    @IBAction func start(_ sender: Any) {
        timer.restart()
    }
    
    @IBAction func stop(_ sender: Any) {
        timer.invalidate()
    }
}

extension CountDownTimerExampleVC: StoryboardIdentifiable {
    static var storyboardName: String = "CountDownTimerExampleVC"
    static var storyboardIdentifier: String = "CountDownTimerExampleVC"
}
