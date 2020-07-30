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

    var dict = [String: ImagePrefetcher]()

    private let demoList: [ExampleListItem] = [
        ExampleListItem(title: "UIStackView", jumpClass: ExampleStackViewVC.self),
        ExampleListItem(title: "RxSwift", jumpClass: ExampleRxSwiftVC.self),
        ExampleListItem(title: "IBDesignableKit", jumpClass: IBDesignableKitVC.self),
        ExampleListItem(title: "富文本", jumpClass: RichTextViewController.self),
        ExampleListItem(title: "Popver", jumpClass: PopverViewController.self),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

//        var limitDate = Date().adjust(.hour, offset: 22).adjust(.minute, offset: 0).adjust(.second, offset: 0)
//        var nowDate = Date().adjust(.hour, offset: 20).adjust(.minute, offset: 0).adjust(.second, offset: 0)
//
//        let value = limitDate.timeIntervalSince(nowDate) // <= 7200
//        print("")

//        let command = "我是xxx，你已经xxxx天没有来看我了？我在 花间等你##回来，>fu zhi*******<这段话打 开【花间app】"
        ////        let command = "fu zhi#*******#"
//        let isValid = NSPredicate(format: "SELF MATCHES %@", "([\\s\\S]*#[\\s\\S]*){2,}").evaluate(with: command)
//        print(isValid ? "正确口令" : "错误口令")

//        let key: String = nil
//        if false {
//            key = ""
//        }

//        let queue = DispatchQueue.global()
//
//        for _ in 0 ..< 10 {
//            let wrapper = CountWrapper()
//            for _ in 0 ..< 100 {
//                queue.async {
//                    self.safeDictAdd(key: "key",wrapper: wrapper)
//                }
//                queue.async {
//                    self.safeDictRemove(key: "key",wrapper:wrapper)
//                }
//                //            var urlString: [String] = []
//                //            for _ in 0 ..< 100 {
//                //                urlString.append("http://fdfs-uat.tyi365.com/img/M00/00/0A/rB_IzV1Q1yaAGXS2AAKwcjY3Svc979.jpg")
//                //            }
//                //            let urls: [URL] = urlString.compactMap { URL(string: $0) }
//                //            let imagePrefetcher = ImagePrefetcher(urls: urls, options: [], progressBlock: nil, completionHandler: { [weak self] _, _, _ in
//                //                print("---- thread -- 1 = \(Thread.current)")
//                //                guard let self = self else { return }
//                //                self.safeDictRemove(key: "key")
//                //            })
//                //            print("---- thread -- 2 = \(Thread.current)")
//                //            imagePrefetcher.maxConcurrentDownloads = 10
//                //            imagePrefetcher.start()
//                //            safeDictAdd(key: "key", p: imagePrefetcher)
//            }
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
//                self.safeCount(wrapper: wrapper)
//            }
//        }

//
        ////        for _ in 0 ..< 1 {
//            DispatchQueue.global().async {
//                dict.removeValue(forKey: "key")
//            }
        ////        }
        ////        for _ in 0 ..< 1 {
//            DispatchQueue.global().async {
//                dict["key"] = imagePrefetcher
//            }
        ////        }

        /*
          债市涨跌背后逻辑(利率、货币流动性、经济)
             1. 利率上涨，债市下跌；利率下跌，债市上涨
                 市场存量债券比新发债券数量大的多，存量债券占债市主导地位，因此影响债市走势的是存量债券。
                 比如十年期国债利率是3%，此时如果要发行债券，那么利率需要高于3%p才能借到钱(比如给出年利率5%)。
                 此时我购买了该债券，购买半年后突然急需用钱，而此时债券还未到期，钱拿不回来，只能到二级市场将该债券转手。
                 如果这时候利率也上调至5%，市面上新发的债券利率肯定高于5%，有可能是8%。而此时我手中的5%跟8%相差了3个百分点，那么我此时只能降价出售，这就利率上涨导致债市下跌。
                 如果此时利率下调至1%，市面上新发债券利率可能是3%，和5%少了2个点，那此时我的债券就能卖到更多的钱，这就是利率下调导致债券上涨。
             2. 流动性宽松，债市上涨；流动性收紧，债市下跌
                 流动性宽松，资金就多，资金的价格就下降，而资金的价格就是利率。因此流动性宽松利率下降，从而债市上涨；流动性收紧利率上涨，债市下跌
             3. 未来经济向上，债市下跌；未来经济向下，债市上涨
                 经济不好，央行就会放水，降低利息，提高流动性，而此时
         */

        // cell 赋值
        datasource.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: ExampleListCell.self)) { _, model, cell in
            cell.titleLabel.text = model.title
            cell.jumpClassLabel.text = NSStringFromClass(model.jumpClass)
        }.disposing(with: self)

        // table 点击事件
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            let item = self.demoList[indexPath.item]
            if let vc = self.instanceJumpVC(item: item) {
                vc.title = item.title
                vc.view.backgroundColor = .white
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
