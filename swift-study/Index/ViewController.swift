//
//  ViewController.swift
//  swift-study
//
//  Created by 永平 on 2020/7/6.
//  Copyright © 2020 永平. All rights reserved.
//

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
    
    private let demoList: [ExampleListItem] = [
        ExampleListItem(title: "UIStackView", jumpClass: ExampleStackViewVC.self),
        ExampleListItem(title: "RxSwift", jumpClass: ExampleRxSwiftVC.self),
        ExampleListItem(title: "IBDesignableKit", jumpClass: IBDesignableKitVC.self),
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
        }
        return nil
    }
}
