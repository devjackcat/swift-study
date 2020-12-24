//
//  PersonAttachmentDecoder.swift
//  swift-study
//
//  Created by 永平 on 2020/12/24.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation

public class PersonAttachmentDecoder: IMCustomAttachmentDecoderProtocol {
    public func decodeAttachment(type: Int, msgType: Int, data: [String : Any]) -> NIMCustomAttachment? {
        if type == 2020 {
            return IMChatAttachment<PersonVO>(type: type, data: data)
        }
        return nil
    }
    
    public init() { }
}
