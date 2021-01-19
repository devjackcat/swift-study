//
//  PopverViewController.swift
//  swift-study
//
//  Created by 永平 on 2020/7/30.
//  Copyright © 2020 永平. All rights reserved.
//

import RxSwift
import UIKit


class PopverViewController: UIViewController {
    var popver: Popover?

    var processMaskView = UIView()
    var tagView = UIView()
    let processTotalHeight: CGFloat = 300
    var processPercent: CGFloat = 0 {
        didSet {
            let height = max(min(processTotalHeight * processPercent, processTotalHeight), 0)
            processMaskView.frame = CGRect(x: 0, y: processTotalHeight - height, width: 50, height: height)

            tagView.snp.updateConstraints { make in
                make.top.equalTo((processTotalHeight - 7) - height)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let processContainerView = UIView().jcs_layout(superView: self) { make in
            make.center.equalTo(self.view)
            make.width.equalTo(200)
            make.height.equalTo(processTotalHeight)
        }

        let processView = UIView().jcs_layout(superView: processContainerView) { make in
            make.left.top.bottom.equalTo(processContainerView)
            make.width.equalTo(50)
        }
        .jcs_backgroundColor(0xFF0000)
        .jcs_cornerRadius(25)

        processMaskView = UIView()
        processMaskView.backgroundColor = .black
        processMaskView.frame = CGRect(x: 0, y: processTotalHeight, width: 150, height: 0)
        processView.mask = processMaskView

        let tagImageView = UIImageView(image: UIImage(named: "tabel_01"))
        tagImageView.jcs_layout(superView: tagView) { make in
            make.edges.equalTo(tagView)
        }
        tagView.jcs_layout(superView: processContainerView) { make in
            make.left.equalTo(processView.snp.right)
            make.top.equalTo(processTotalHeight - 7)
            make.width.equalTo(32)
            make.height.equalTo(14)
        }

        Observable<Int>.interval(0.1, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.processPercent += 0.01
            })
            .disposing(with: self)

        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "Lv.2")
        label.frame = CGRect(x: 20, y: 418, width: 40, height: 10.5)
        label.numberOfLines = 0
        let shadow = NSShadow()
        shadow.shadowColor = UIColor(red: 0.54, green: 0.3, blue: 0.17, alpha: 1)
        shadow.shadowBlurRadius = 0
        shadow.shadowOffset = CGSize(width: 0, height: 1)

        let attr: [NSAttributedString.Key: Any] = [.font: UIFont(name: "PingFangSC-Semibold", size: 14), .foregroundColor: UIColor(red: 0.96, green: 0.96, blue: 1, alpha: 1), .shadow: shadow]
        attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
        label.attributedText = attrString
        view.addSubview(label)
    }

    @IBAction func showPopver1(sender: UIButton) {
        let selector = PopverContentView.fromNib()
        selector.frame = CGRect(x: 0, y: 0, width: 120, height: 150)

        let popover = Popover(options: [.type(.auto),
                                        .color(UIColor.clear),
                                        .blackOverlayColor(.clear)])
        popover.didDismissHandler = { [weak self] in
            self?.popver = nil
        }
        popover.show(selector, fromView: sender)
        popver = popover
    }
}

extension PopverViewController: StoryboardIdentifiable {
    static var storyboardName: String = "PopverViewController"
    static var storyboardIdentifier: String = "PopverViewController"
}
