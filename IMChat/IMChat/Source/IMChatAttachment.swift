//
//  IMChatAttachment.swift
//  swift-study
//
//  Created by 永平 on 2020/12/23.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation
import AppFoundation
import NIMSDK
import HandyJSON

public protocol IMChatAttachmentProtocol: HandyJSON {
    static var identifier: (type: Int, keyPath: String) { get }
}

public class IMChatAttachment<T: IMChatAttachmentProtocol>: NSObject, NIMCustomAttachment {
    
    public class Wrapper: HandyJSON {
        public var type = 0
        public var msgType = 0
        public var vo: T?
        public required init() {}
    }
    
    public private(set) var wrapper = Wrapper()
    private var decodeKeyPath: String?
    
    public init(type: Int, data: [String: Any]) {
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
