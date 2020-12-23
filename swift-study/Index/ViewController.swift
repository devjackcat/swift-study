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

import URLNavigator

class ViewController: UIViewController {
    
    typealias ExampleListItem = ExampleViewModel.ExampleListItem
    
    @IBOutlet var tableView: UITableView!
    private var bag = DisposeBag()
    private var datasource: BehaviorRelay = BehaviorRelay<[ExampleListItem]>(value: [])
    
    private let viewModel = ExampleViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // cell 赋值
        datasource.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: ExampleListCell.self)) { _, model, cell in
            cell.titleLabel.text = model.title
            cell.jumpClassLabel.text = model.route
        }.disposing(with: self)

        // table 点击事件
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            let item = self.viewModel.demoList[indexPath.item]

            TinyConsole.print("进入 \(item.title)", color: .red)
            JCRouter.route(url: item.route)
            
        }).disposing(with: self)

        // 触发数据
        datasource.accept(viewModel.demoList)
    }
}


extension ViewController: StoryboardIdentifiable {
    static var storyboardName: String = "Main"
    static var storyboardIdentifier: String = "ViewController"
}




class CountWrapper {
    var count = 0
}

extension ViewController {
//    enum TestEnum {
//        case demo(a: String, b: String? = nil, c: Int)
//    }
//    var dict = [String: ImagePrefetcher]()
//    fileprivate let tempQueue = DispatchQueue(label: "Com.BigNerdCoding.SafeArray", attributes: .concurrent)
//    let group = DispatchGroup()
//    let signal = DispatchSemaphore(value: 1)
//
//    func safeDictAdd(key _: String, wrapper: CountWrapper, p _: ImagePrefetcher? = nil) {
//        Thread.sleep(forTimeInterval: 0.01)
////        objc_sync_enter(self)
////        queue.sync {
////            dict[key] = p
////        }
////        objc_sync_exit(dict)
//
//        signal.wait()
//        wrapper.count += 1
//        signal.signal()
//
////        group.enter()
////        wrapper.count += 1
////        group.leave()
//
////        objc_sync_enter(dict)
////        wrapper.count += 1
////        objc_sync_exit(dict)
//    }
//
//    func safeDictRemove(key _: String, wrapper: CountWrapper) {
//        signal.wait()
//        wrapper.count -= 1
//        signal.signal()
//
////        group.enter()
////        wrapper.count -= 1
////        group.leave()
//
////        objc_sync_enter(dict)
////        wrapper.count -= 1
////        objc_sync_exit(dict)
//    }
//
//    func safeCount(wrapper: CountWrapper) {
////        signal.wait()
////        print("---count = \(wrapper.count)")
////        signal.signal()
//
////        objc_sync_enter(dict)
//        print("---count = \(wrapper.count)")
////        objc_sync_exit(dict)
//    }
}
