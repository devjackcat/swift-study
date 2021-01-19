//
//  UICollectionView+JCS_Create.swift
//  AppFoundation
//
//  Created by 永平 on 2021/1/19.
//

import UIKit

public extension UICollectionView {
    
    @discardableResult func jcs_registerCellClass(_ clazz: UICollectionViewCell.Type, identifier: String) -> Self {
        register(clazz, forCellWithReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult func jcs_registerSectionHeaderClass(_ clazz: UICollectionReusableView.Type, identifier: String) -> Self {
        register(clazz, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier)
        return self
    }
    @discardableResult func jcs_registerSectionFooterClass(_ clazz: UICollectionReusableView.Type, identifier: String) -> Self {
        register(clazz, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier)
        return self
    }
    
    @discardableResult func jcs_delegate(_ delegate: UICollectionViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    @discardableResult func jcs_delegate(_ dataSource: UICollectionViewDataSource) -> Self {
        self.dataSource = dataSource
        return self
    }
    
    @discardableResult func jcs_customerLayout(_ layout: UICollectionViewLayout, animated: Bool = false) -> Self {
        setCollectionViewLayout(layout, animated: animated)
        return self
    }
    
}
