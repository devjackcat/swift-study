//
//  IMChatModule.swift
//  IMChat
//
//  Created by 永平 on 2020/12/24.
//

import Foundation

public class IMChatModule {
    public static func register(appKey: String, apnsCername: String? = nil) {
        IMChatEngine.shared.register(appKey: appKey, apnsCername: apnsCername)
    }
    public static func login(account: String, token: String) {
        IMChatEngine.shared.login(account: account, token: token)
    }
}
