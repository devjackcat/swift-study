//
//  OrderVO.swift
//  swift-study
//
//  Created by 永平 on 2020/12/24.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation

class OrderVO: IMChatAttachmentProtocol {
    static var identifier: (type: Int, keyPath: String) {
        return (0,"msgJson")
    }
    var orderNo: String?
    var price: String?
    
    required init() {}
}
