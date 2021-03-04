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
import RxSwift

class CountDownTimerExampleVC: UIViewController {
    
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var processLabel: UILabel!
    
    private var timer: CountDownTimer!
    
    // 倒计时30s
    let duration: TimeInterval = 30
    
    override func viewDidLoad() {
//        timer = CountDownTimer(total: duration, repeat: 1) { [weak self] (timer, interval) in
//            self?.statusLabel.text = "进行中"
//            self?.processLabel.text = ""
//        } handler: { [weak self]  (timer, interval) in
//            guard let self = self else { return }
//            self.processLabel.text = "总时长\(self.duration)s, 当前\(Int(interval))s"
//        } timeOut: { [weak self]  (timer, interval) in
//            self?.statusLabel.text = ""
//            self?.processLabel.text = ""
//        }
        
//        let v = JCDemoView.fromNib()
//        view.addSubview(v)
//        v.snp.makeConstraints { (make) in
//            make.center.equalTo(self.view)
//            make.width.height.equalTo(200)
//        }
    }
    
    var animationFinish = false
    var networkFinish = false
    
    @IBAction func start(_ sender: Any) {
//        timer.restart()
        
//        Observable.just(true).delay(.seconds(3), scheduler: MainScheduler.instance)
//            .subscribe(onNext: {
//                print($0)
//            })
//            .disposing(with: self)
        
        let animationObservable = Observable.just(true).delay(.seconds(2), scheduler: MainScheduler.instance)
        let networkObservable = Observable.just(true).delay(.seconds(1), scheduler: MainScheduler.instance)
        
        Observable.combineLatest(animationObservable,networkObservable)
            .subscribe(onNext: { [weak self] (animationFinish, networkFinish) in
                guard let self = self else { return }
                self.animationFinish = self.animationFinish || animationFinish
                self.networkFinish = self.networkFinish || networkFinish
                
                print("----self.animationFinish = \(self.animationFinish)  self.networkFinish = \(self.networkFinish)")
            })
            .disposing(with: self)
    }
    
    @IBAction func stop(_ sender: Any) {
//        timer.invalidate()
    }
}

extension CountDownTimerExampleVC: StoryboardIdentifiable {
    static var storyboardName: String = "CountDownTimerExampleVC"
    static var storyboardIdentifier: String = "CountDownTimerExampleVC"
}
