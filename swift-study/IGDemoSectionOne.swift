//
//  ListSectionOne.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import IGListKit
import UIKit

class IGDemoSectionOne: ListSectionController {
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = (collectionContext?.dequeueReusableCell(of: IGDemoCell1.self, withReuseIdentifier: "IGDemoCell1", for: self, at: index)) as! IGDemoCell1

//        cell.configData(data: collectionContext.)
        return cell
    }

    override func sizeForItem(at _: Int) -> CGSize {
        return CGSize(width: (collectionContext?.containerSize.width)!, height: 55)
    }
}
