//
//  IMChatAttachment.swift
//  swift-study
//
//  Created by 永平 on 2020/12/23.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation
import NIMSDK
import HandyJSON

public protocol IMChatAttachmentProtocol: HandyJSON {
    static var identifier: (type: Int, keyPath: String) { get }
}

public class IMChatAttachment<T: IMChatAttachmentProtocol>: NSObject, NIMCustomAttachment {
    
    class Wrapper: HandyJSON {
        var type = 0
        var msgType = 0
        var vo: T?
        required init() {}
    }
    
    private(set) var wrapper = Wrapper()
    private var decodeKeyPath: String?
    
    init(type: Int, data: [String: Any]) {
        var reData = data
        for keyPath in ["commonMsgJson", T.identifier.keyPath] {
            if let vo = data[keyPath] {
                decodeKeyPath = keyPath
                reData["vo"] = vo
                break
            }
        }
        if let wrapper = Wrapper.deserialize(from: reData) {
            wrapper.type = type
            self.wrapper = wrapper
        }
    }
    
    public func encode() -> String {
        var json = wrapper.toJSON() ?? [:]
        let decodeKeyPath = self.decodeKeyPath ?? T.identifier.keyPath
        json[decodeKeyPath] = json["vo"]
        json.removeValue(forKey: "vo")

        return ["type": T.identifier.type,
                "data": json].toJSONSerializationString() ?? ""
    }
    
}
