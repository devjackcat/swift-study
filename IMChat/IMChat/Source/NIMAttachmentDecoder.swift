//
//  NIMAttachmentDecoder.swift
//  swift-study
//
//  Created by 永平 on 2020/12/24.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation
import NIMSDK

public protocol IMCustomAttachmentDecoderProtocol {
    func decodeAttachment(type: Int, msgType: Int, data: [String: Any]) -> NIMCustomAttachment?
}

class HJNIMAttachmentDecoder: NSObject, NIMCustomAttachmentCoding {

    var decoders: [IMCustomAttachmentDecoderProtocol] = []
    init(decoders: [IMCustomAttachmentDecoderProtocol]) {
        self.decoders = decoders
    }
    
    func decodeAttachment(_ content: String?) -> NIMCustomAttachment? {
        guard let utf8Data = content?.data(using: .utf8), let json = (try? JSONSerialization.jsonObject(with: utf8Data, options: [])) as? [String: Any] else { return nil }
        
        let type = (json["type"] as? Int) ?? 0
        let data = (json["data"] as? [String: Any]) ?? [:]
        let msgType = (data["msgType"] as? Int) ?? 0
        
        for decoder in decoders {
            if let attach = decoder.decodeAttachment(type: type, msgType: msgType,  data: data) {
                return attach
            }
        }
        
        return nil
    }
}

public extension IMChatModule {
    static func registerCustomDecoder(_ decoders: [IMCustomAttachmentDecoderProtocol]) {
        NIMCustomObject.registerCustomDecoder(HJNIMAttachmentDecoder(decoders: decoders))
    }
}
