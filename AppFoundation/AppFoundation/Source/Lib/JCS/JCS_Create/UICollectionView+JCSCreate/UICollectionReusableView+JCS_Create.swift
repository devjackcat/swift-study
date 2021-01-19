//
//  UICollectionReusableView+JCS_Create.swift
//  AppFoundation
//
//  Created by 永平 on 2021/1/19.
//

import UIKit

public extension UICollectionReusableView {
    
    class func jcs_getHeaderView(_ collectionView: UICollectionView, identifier: String, indexPath: IndexPath) -> UICollectionReusableView? {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier, for: indexPath)
    }
    
    class func jcs_getFooterView(_ collectionView: UICollectionView, identifier: String, indexPath: IndexPath) -> UICollectionReusableView? {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier, for: indexPath)
    }
}
