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
            JCRouter.route(url: item.route, content: ["title":item.title])

        }).disposing(with: self)

        // 触发数据
        datasource.accept(viewModel.demoList)
        
    }
    
    private var contentView: UIView = UIView()
    private func setup() {
        
        // 头像
        let headerImageView = UIImageView()
            .jcs_cornerRadius(40)
            .jcs_borderWidth(3)
            .jcs_borderColor(.white)
            .jcs_userInteractionEnabled(true)
            .jcs_click { _ in
                // TODO: 图片点击事件
            }
            .jcs_layout(superView: contentView) { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(0)
                make.size.equalTo(CGSize(width: 80, height: 80))
            }
        
        // 渐变背景色
        IBCornerRadiusMasksView()
            .jcs_backgroundColor_White()
            .jcs_layout(superView: contentView) { (make) in
                make.left.right.equalToSuperview()
                make.bottom.equalTo(view)
                make.top.equalTo(headerImageView.snp.centerY)
            }
        
        // 昵称
        let userNameLabel = UILabel(text: nil, font: .systemFont(ofSize: 18, weight: .semibold), color: UIColor(hex: 0x15161A))
            .jcs_textAlignment_Center()
            .jcs_layout(superView: contentView) { (make) in
                make.centerX.equalTo(headerImageView)
                make.top.equalTo(headerImageView.snp.bottom).offset(10)
                make.left.right.equalTo(0)
                make.height.equalTo(19)
            }

        let remarkLabel = UILabel(text: nil, font: .systemFont(ofSize: 14, weight: .regular), color: UIColor(hex: 0x8C8E97))
            .jcs_textAlignment_Center()
            .jcs_layout(superView: contentView) { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(userNameLabel.snp.bottom).offset(10)
            }
        
        UIButton()
            .jcs_image(UIImage(named: "zb_btn_follow"))
            .jcs_click { _ in
                // TODO: 点击事件
            }.jcs_layout(superView: contentView) { make in
                make.size.equalTo(CGSize(width: 230, height: 40))
                make.centerX.equalToSuperview()
                make.top.equalTo(remarkLabel.snp.bottom).offset(16)
            }
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
