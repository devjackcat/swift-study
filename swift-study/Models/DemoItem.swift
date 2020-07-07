//
//  DemoItem.swift
//  swift-study
//
//  Created by 永平 on 2020/5/25.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

class DemoItem {
    var title: String = ""

    convenience init(title: String) {
        self.init()
        self.title = title
    }
}
