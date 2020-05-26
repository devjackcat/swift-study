//
//  IGDemoVC.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit
import IGListKit

class IGDemoVC: JCS_BaseVC, ListAdapterDataSource {
    
    var collectionView: UICollectionView!
    var adapter: ListAdapter!
    
    override func jcs_setup() {
        _ = self.view.jcs_backgroundColor_White()
        
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
            .jcs_layout(superView: self, layout: { (make) in
                make.left.top.right.bottom.equalTo(0)
            })
            .jcs_backgroundColor_White()
            .jcs_toCollectionView()
        
        let updater = ListAdapterUpdater()
        self.adapter = ListAdapter(updater: updater, viewController: self)
        adapter.collectionView = self.collectionView
        adapter.dataSource = self
    }
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [
            "Foo" as ListDiffable,
            "Bar" as ListDiffable,
            42 as ListDiffable,
            "Biz" as ListDiffable]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return IGDemoSectionOne()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
