//
//  IMChatEngine.swift
//  AppFoundation
//
//  Created by 永平 on 2020/12/24.
//

import UIKit
import NIMSDK
import RxCocoa
import RxSwift


class IMChatEngine: NSObject {
    public private(set) static var shared = IMChatEngine()
    private override init() {}
    
    // 存储所有的chatManager
    private var chatManagerMap = [String: NSPointerArray]()
    
    func register(appKey: String, apnsCername: String? = nil) {
        let option = NIMSDKOption(appKey: appKey)
        option.apnsCername = apnsCername
        NIMSDK.shared().register(with: option)
        NIMSDK.shared().chatManager.add(self)
    }
    
    func login(account: String, token: String) {
        NIMSDK.shared().loginManager.login(account, token: token) { error in
            print("----云信登陆 \(String(describing: error))")
        }
    }
}

extension IMChatEngine: NIMChatManagerDelegate {
    public func onRecvMessages(_ messages: [NIMMessage]) {
        guard chatManagerMap.count > 0, messages.count > 0 else { return }

        var map = [String: [NIMMessage]]()
        messages.forEach {
            if let sessionId = $0.session?.sessionId {
                var msgs: [NIMMessage]! = map[sessionId]
                if msgs == nil {
                    msgs = [NIMMessage]()
                }
                msgs.append($0)
                map[sessionId] = msgs
            }
        }

        for (sessionId, messages) in map {
            findChatManagers(for: sessionId)
                .forEach {
                    $0.callabckers.forEach {
                        $0.callback(messages: messages)
                    }
                }
        }
    }
    public func willSend(_ message: NIMMessage) {
        // 不管是否发送成功，都做本地逻辑，避免聊天室掉线没有本地效果的问题
        guard !chatManagerMap.isEmpty else { return }
        guard let sessionId = message.session?.sessionId else { return }

        findChatManagers(for: sessionId)
            .forEach {
                $0.sendMessageClosures.forEach {
                    $0(message)
                }
                $0.callabckers.forEach {
                    $0.callback(messages: [message])
                }
            }
    }
    
    private func findChatManagers(for sessionId: String) -> [IMChatManager] {
        return chatManagerMap[sessionId]?.allObjects as? [IMChatManager] ?? []
    }
    
    func addChatManager(chatManager: IMChatManager) {
        let sessionId = chatManager.session.sessionId
        var pointers: NSPointerArray! = chatManagerMap[sessionId]
        if pointers == nil {
            pointers = NSPointerArray.weakObjects()
            chatManagerMap[sessionId] = pointers
        }
        let pointer = Unmanaged.passUnretained(chatManager).toOpaque()
        pointers.addPointer(pointer)
    }
    
    func removeChatManager(chatManager: IMChatManager) {
        let sessionId = chatManager.session.sessionId
        if let pointers = chatManagerMap[sessionId] {
            if pointers.allObjects.count == 0 {
                chatManagerMap.removeValue(forKey: sessionId)
            }
        }
    }
}
