//
//  DemoReactorVC.swift
//  swift-study
//
//  Created by 永平 on 2020/6/11.
//  Copyright © 2020 永平. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxRelay
import RxSwift
import UIKit

class DemoReactorVC: UIViewController, View {
    typealias Reactor = CounterViewReactor

    private var plusBtn: UIButton!
    private var minusBtn: UIButton!
    private var valueLabel: UILabel!
    private var activityIndicatorView: UIActivityIndicatorView!

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        reactor = CounterViewReactor()
    }

    func bind(reactor: CounterViewReactor) {
        plusBtn.rx.tap
            .map { Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        minusBtn.rx.tap
            .map { Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        reactor.state.map { $0.value }
            .distinctUntilChanged()
            .map { "\($0)" }
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)

        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: activityIndicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    }

    func setupUI() {
        view.jcs_backgroundColor_White()

        plusBtn = UIButton()
            .jcs_title("Plus")
            .jcs_titleColor(0x000000)
            .jcs_layout(superView: self, layout: { make in
                make.left.equalTo(20)
                make.width.equalTo(100)
                make.height.equalTo(44)
                make.top.equalTo(200)
            })

        minusBtn = UIButton()
            .jcs_title("Minus")
            .jcs_titleColor(0x000000)
            .jcs_layout(superView: self, layout: { make in
                make.right.equalTo(-20)
                make.width.equalTo(100)
                make.height.equalTo(44)
                make.top.equalTo(200)
            })

        valueLabel = UILabel(text: "0", font: .systemFont(ofSize: 20), color: .black)
            .jcs_layout(superView: self, layout: { make in
                make.center.equalTo(self.view)
            })

        activityIndicatorView = UIActivityIndicatorView(style: .large)
            .jcs_layout(superView: self, layout: { make in
                make.center.equalTo(self.view)
            })
        activityIndicatorView.color = UIColor.black
    }
}
