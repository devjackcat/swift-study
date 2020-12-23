//
//  IMAttachment.swift
//  swift-study
//
//  Created by 永平 on 2020/12/23.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation

import HandyJSON

public protocol IMAttachmentProtocol: HandyJSON {
    static var identifier: (type: Int, keyPath: String) { get }
}

public class IMAttachment<T: IMAttachmentProtocol> {
    
    class Wrapper: HandyJSON {
        var msgType = 0
        var subType = 0
        var vo: T?
        required init() {}
    }
    
    private(set) var wrapper = Wrapper()
    
    init(data: [String: Any]) {
        var reData = data
        for keyPath in ["commonMsgJson", T.identifier.keyPath] {
            if let vo = data[keyPath] {
                reData["vo"] = vo
            }
        }
        if let wrapper = Wrapper.deserialize(from: reData) {
            self.wrapper = wrapper
        }
    }
}
