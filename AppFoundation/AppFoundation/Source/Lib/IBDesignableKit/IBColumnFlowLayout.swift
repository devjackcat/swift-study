//
//  ColumnFlowLayout.swift
//  IBDemo
//
//  Created by Cheng.dh on 2019/11/20.
//  Copyright © 2019 chengdonghai. All rights reserved.
//

import UIKit

/// 可设置列数的UICollectionViewFlowLayout
@IBDesignable
public class IBColumnFlowLayout: UICollectionViewFlowLayout {
    /// 列数
    @IBInspectable var column: Int = 1
    /// 是否按宽高比设置高度
    @IBInspectable var ratio: Bool = false
    /// 高度或者宽高比
    @IBInspectable var height: CGFloat = 50
    /// 左边距
    @IBInspectable var sectionLeft: CGFloat {
        get {
            sectionInset.left
        }
        set {
            sectionInset.left = newValue
        }
    }

    /// 右边距
    @IBInspectable var sectionRight: CGFloat {
        get {
            sectionInset.right
        }
        set {
            sectionInset.right = newValue
        }
    }

    /// 上边距
    @IBInspectable var sectionTop: CGFloat {
        get {
            sectionInset.top
        }
        set {
            sectionInset.top = newValue
        }
    }

    /// 下边距
    @IBInspectable var sectionBottom: CGFloat {
        get {
            sectionInset.bottom
        }
        set {
            sectionInset.bottom = newValue
        }
    }

    /// 行高
    @IBInspectable var lineSpace: CGFloat {
        get {
            minimumLineSpacing
        }
        set {
            minimumLineSpacing = newValue
        }
    }

    /// 列间距
    @IBInspectable var interitemSpace: CGFloat {
        get {
            self.minimumInteritemSpacing
        }
        set {
            self.minimumInteritemSpacing = newValue
        }
    }

    public override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        let width = collectionView.bounds.width
        let itemWidth = floor((width - (CGFloat(column - 1) * minimumInteritemSpacing) - sectionInset.left - sectionInset.right) / CGFloat(column))
        itemSize = CGSize(width: itemWidth, height: ratio ? height * itemWidth : height)
    }
}
