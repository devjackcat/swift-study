//
//  UICollectionViewCell+JCS_Create.swift
//  AppFoundation
//
//  Created by 永平 on 2021/1/19.
//

import UIKit

public extension UICollectionViewCell {
    
    class func jcs_getCell(_ collectionView: UICollectionView, identifier: String, indexPath: IndexPath) -> UICollectionViewCell? {
        return collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }
    
}
