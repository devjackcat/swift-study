//
//  PersonVO.swift
//  swift-study
//
//  Created by 永平 on 2020/12/23.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation

class PersonVO: IMChatAttachmentProtocol {
    static var identifier: (type: Int, keyPath: String) {
        return (0,"msgJson")
    }
    var username: String?
    var nickname: String?
    var age: Int?
    required init() {}
}
