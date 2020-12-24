//
//  NIMAttachmentDecoder.swift
//  swift-study
//
//  Created by 永平 on 2020/12/24.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation
import NIMSDK

protocol IMCustomAttachmentDecoder {
    static func decodeAttachment(type: Int, msgType: Int, data: [String: Any]) -> NIMCustomAttachment?
}

class HJNIMAttachmentDecoder: NSObject, NIMCustomAttachmentCoding {
    func decodeAttachment(_ content: String?) -> NIMCustomAttachment? {
        guard let utf8Data = content?.data(using: .utf8), let json = (try? JSONSerialization.jsonObject(with: utf8Data, options: [])) as? [String: Any] else { return nil }
        
        let type = (json["type"] as? Int) ?? 0
        let data = (json["data"] as? [String: Any]) ?? [:]
        let msgType = (data["msgType"] as? Int) ?? 0
        
        if let attach = OrderAttachmentDecoder.decodeAttachment(type: type, msgType: msgType,  data: data) { return attach }
        if let attach = PersonAttachmentDecoder.decodeAttachment(type: type, msgType: msgType,  data: data) { return attach }
        
        return nil
    }
}

class OrderAttachmentDecoder: IMCustomAttachmentDecoder {
    static func decodeAttachment(type: Int, msgType: Int, data: [String : Any]) -> NIMCustomAttachment? {
        if type == 2020 {
            return IMChatAttachment<PersonVO>(type: type, data: data)
        }
        return nil
    }
}

class PersonAttachmentDecoder: IMCustomAttachmentDecoder {
    static func decodeAttachment(type: Int, msgType: Int, data: [String : Any]) -> NIMCustomAttachment? {
        if type == 2021 {
            return IMChatAttachment<OrderVO>(type: type, data: data)
        }
        return nil
    }
}
