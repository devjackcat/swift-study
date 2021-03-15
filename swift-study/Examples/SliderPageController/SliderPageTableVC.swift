//
//  SliderPageTableVC.swift
//  swift-study
//
//  Created by 永平 on 2021/3/15.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit

class SliderPageTableVC: UIViewController {

    var datasource: [String] = []
    private var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView().jcs_layout(superView: self) { (make) in
            make.left.top.right.bottom.equalTo(0)
        }
        .jcs_registerCellClass(UITableViewCell.self, identifier: "cell")
        .jcs_dataSource(self)
    
        tableView?.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("-----SliderPageTableVC----viewDidAppear")
    }
    
}

extension SliderPageTableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = datasource[indexPath.item]
        return cell
    }
}
