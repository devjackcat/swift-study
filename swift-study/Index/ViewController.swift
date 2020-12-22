//
//  ViewController.swift
//  swift-study
//
//  Created by 永平 on 2020/7/6.
//  Copyright © 2020 永平. All rights reserved.
//

import Kingfisher
import RxCocoa
import RxSwift
import UIKit

struct ExampleListItem {
    var title: String = ""
    var jumpClass: UIViewController.Type = UIViewController.self
}

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    private var bag = DisposeBag()
    private var datasource: BehaviorRelay = BehaviorRelay<[ExampleListItem]>(value: [])

    enum TestEnum {
        case demo(a: String, b: String? = nil, c: Int)
    }

    var dict = [String: ImagePrefetcher]()

    private let demoList: [ExampleListItem] = [
        ExampleListItem(title: "TinyConsole", jumpClass: UIViewController.self),
        ExampleListItem(title: "UIStackView", jumpClass: ExampleStackViewVC.self),
        ExampleListItem(title: "RxSwift", jumpClass: ExampleRxSwiftVC.self),
        ExampleListItem(title: "IBDesignableKit", jumpClass: IBDesignableKitVC.self),
        ExampleListItem(title: "富文本", jumpClass: RichTextViewController.self),
        ExampleListItem(title: "Popver", jumpClass: PopverViewController.self),
        ExampleListItem(title: "礼物气泡(样式1)", jumpClass: HJGiftPopDemoViewController.self),
        ExampleListItem(title: "礼物气泡(样式2)", jumpClass: HJGiftPopDemoViewController.self),
        ExampleListItem(title: "Modal", jumpClass: ModalDemoViewController.self),
        ExampleListItem(title: "TouchTrough", jumpClass: DemoTouchTroughVC.self),
        ExampleListItem(title: "倒计时", jumpClass: CountDownTimerExampleVC.self),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // cell 赋值
        datasource.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: ExampleListCell.self)) { _, model, cell in
            cell.titleLabel.text = model.title
            cell.jumpClassLabel.text = NSStringFromClass(model.jumpClass)
        }.disposing(with: self)

        // table 点击事件
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            let item = self.demoList[indexPath.item]

            TinyConsole.print("进入 \(item.title)", color: .red)

            // 日志
            if item.title == "TinyConsole" {
                TinyConsole.toggleWindowMode()

                return
            }
            if let vc = self.instanceJumpVC(item: item) {
                vc.title = item.title
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }).disposing(with: self)

        // 触发数据
        datasource.accept(demoList)
    }

    func instanceJumpVC(item: ExampleListItem) -> UIViewController? {
        if item.jumpClass == ExampleStackViewVC.self {
            return ExampleStackViewVC.instantiateFromStoryboard()
        } else if item.jumpClass == IBDesignableKitVC.self {
            return IBDesignableKitVC.instantiateFromStoryboard()
        } else if item.jumpClass == ExampleRxSwiftVC.self {
            return ExampleRxSwiftVC.instantiateFromStoryboard()
        } else if item.jumpClass == RichTextViewController.self {
            return RichTextViewController.instantiateFromStoryboard()
        } else if item.jumpClass == PopverViewController.self {
            return PopverViewController.instantiateFromStoryboard()
        } else if item.jumpClass == HJGiftPopDemoViewController.self, item.title == "礼物气泡(样式1)" {
            let vc = HJGiftPopDemoViewController.instantiateFromStoryboard()
            vc.pandaMaster = .Anchor
            return vc
        } else if item.jumpClass == HJGiftPopDemoViewController.self, item.title == "礼物气泡(样式2)" {
            let vc = HJGiftPopDemoViewController.instantiateFromStoryboard()
            vc.pandaMaster = .Audience
            return vc
        } else if item.jumpClass == ModalDemoViewController.self {
            return ModalDemoViewController()
        } else if item.jumpClass == DemoTouchTroughVC.self {
            return DemoTouchTroughVC()
        } else if item.jumpClass == CountDownTimerExampleVC.self {
            return CountDownTimerExampleVC.instantiateFromStoryboard()
        }

        return nil
    }

    fileprivate let tempQueue = DispatchQueue(label: "Com.BigNerdCoding.SafeArray", attributes: .concurrent)

    let group = DispatchGroup()
    let signal = DispatchSemaphore(value: 1)

    func safeDictAdd(key _: String, wrapper: CountWrapper, p _: ImagePrefetcher? = nil) {
        Thread.sleep(forTimeInterval: 0.01)
//        objc_sync_enter(self)
//        queue.sync {
//            dict[key] = p
//        }
//        objc_sync_exit(dict)

        signal.wait()
        wrapper.count += 1
        signal.signal()

//        group.enter()
//        wrapper.count += 1
//        group.leave()

//        objc_sync_enter(dict)
//        wrapper.count += 1
//        objc_sync_exit(dict)
    }

    func safeDictRemove(key _: String, wrapper: CountWrapper) {
        signal.wait()
        wrapper.count -= 1
        signal.signal()

//        group.enter()
//        wrapper.count -= 1
//        group.leave()

//        objc_sync_enter(dict)
//        wrapper.count -= 1
//        objc_sync_exit(dict)
    }

    func safeCount(wrapper: CountWrapper) {
//        signal.wait()
//        print("---count = \(wrapper.count)")
//        signal.signal()

//        objc_sync_enter(dict)
        print("---count = \(wrapper.count)")
//        objc_sync_exit(dict)
    }
}

class CountWrapper {
    var count = 0
}

extension ViewController: StoryboardIdentifiable {
    static var storyboardName: String = "Main"
    static var storyboardIdentifier: String = "ViewController"
}
