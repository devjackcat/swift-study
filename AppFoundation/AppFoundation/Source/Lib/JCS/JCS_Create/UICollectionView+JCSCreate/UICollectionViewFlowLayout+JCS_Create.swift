//
//  UICollectionViewFlowLayout+JCS_Create.swift
//  AppFoundation
//
//  Created by 永平 on 2021/1/19.
//

import UIKit

public extension UICollectionViewFlowLayout {
    
    @discardableResult func jcs_itemSize(_ size: CGSize) -> Self {
        itemSize = size
        return self
    }
    
    @discardableResult func jcs_minimumLineSpacing(_ spacing: CGFloat) -> Self {
        minimumLineSpacing = spacing
        return self
    }
    @discardableResult func jcs_minimumInteritemSpacing(_ spacing: CGFloat) -> Self {
        minimumInteritemSpacing = spacing
        return self
    }
    
    @discardableResult func jcs_headerReferenceSize(_ size: CGSize) -> Self {
        headerReferenceSize = size
        return self
    }
    @discardableResult func jcs_footerReferenceSize(_ size: CGSize) -> Self {
        footerReferenceSize = size
        return self
    }
    
    @discardableResult func jcs_scrollDirection_Vertical() -> Self {
        scrollDirection = .vertical
        return self
    }
    @discardableResult func jcs_scrollDirection_Horizontal() -> Self {
        scrollDirection = .horizontal
        return self
    }
    
    @discardableResult func jcs_sectionInset(_ inset: UIEdgeInsets) -> Self {
        self.sectionInset = inset
        return self
    }
    
}
