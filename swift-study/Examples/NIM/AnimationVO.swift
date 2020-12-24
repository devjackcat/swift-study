//
//  AnimationVO.swift
//  swift-study
//
//  Created by 永平 on 2020/12/24.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation

class AnimationVO: IMChatAttachmentProtocol {
    static var identifier: (type: Int, keyPath: String) {
        return (0,"msgJson")
    }
    var name: String?
    
    required init() {}
}
