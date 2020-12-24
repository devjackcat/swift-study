//
//  MainAttachmentDecoder.swift
//  swift-study
//
//  Created by 永平 on 2020/12/24.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation

public class MainAttachmentDecoder: IMCustomAttachmentDecoderProtocol {
    public func decodeAttachment(type: Int, msgType: Int, data: [String : Any]) -> NIMCustomAttachment? {
        if type == 2022 {
            return IMChatAttachment<AnimationVO>(type: type, data: data)
        }
        return nil
    }
    public init() { }
}
