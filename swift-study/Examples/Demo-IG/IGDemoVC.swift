//
//  IGDemoVC.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import IGListKit
import UIKit

class IGDemoVC: JCS_BaseVC, ListAdapterDataSource {
    var collectionView: UICollectionView!
    var adapter: ListAdapter!

    override func jcs_setup() {
        _ = view.jcs_backgroundColor_White()

        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
            .jcs_layout(superView: self, layout: { make in
                make.left.top.right.bottom.equalTo(0)
            })
            .jcs_backgroundColor_White()
            .jcs_toCollectionView()

        let updater = ListAdapterUpdater()
        adapter = ListAdapter(updater: updater, viewController: self)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    func objects(for _: ListAdapter) -> [ListDiffable] {
        return [
            "Foo" as ListDiffable,
            "Bar" as ListDiffable,
            42 as ListDiffable,
            "Biz" as ListDiffable,
        ]
    }

    func listAdapter(_: ListAdapter, sectionControllerFor _: Any) -> ListSectionController {
        return IGDemoSectionOne()
    }

    func emptyView(for _: ListAdapter) -> UIView? {
        return nil
    }
}
