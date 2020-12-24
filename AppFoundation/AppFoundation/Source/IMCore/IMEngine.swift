//
//  IMEngine.swift
//  AppFoundation
//
//  Created by 永平 on 2020/12/24.
//

import UIKit
import NIMSDK
import RxCocoa
import RxSwift

typealias IMAttachmentClosure<T: NIMCustomAttachment> = (([(message: NIMMessage, attachment: T)]) -> Void)
typealias IMChatroomNotificationClosure = (([(message: NIMMessage, content: NIMChatroomNotificationContent)]) -> Void)
typealias IMSimpleMessageClosure = ((_ message: NIMMessage) -> Void)

private extension NIMMessage {
    func comfirmMode(_ mode: IMChatManager.ListenMode) -> Bool {
        if isReceivedMsg, mode == .all || mode == .receive {
            return true
        }
        if isOutgoingMsg, mode == .all || mode == .send {
            return true
        }
        return false
    }
}

private protocol IMChatCallBacker {
    func callback(messages: [NIMMessage])
}

private struct CallbackerNIMCustomAttachment: IMChatCallBacker {
    var type: AnyClass
    var mode: IMChatManager.ListenMode
    var handler: ([(message: NIMMessage, attachment: NIMCustomAttachment)]) -> Void

    func callback(messages: [NIMMessage]) {
        let results = messages.compactMap { message -> (NIMMessage, NIMCustomAttachment)? in
            if message.comfirmMode(self.mode), let obj = message.messageObject as? NIMCustomObject, let attachment = obj.attachment {
                if Swift.type(of: attachment) == type {
                    return (message, attachment)
                }
            }
            return nil
        }
        if !results.isEmpty {
            handler(results)
        }
    }
}

class IMChatHandlerToken {
    private var callBacker: IMChatCallBacker
    fileprivate init(callBacker: IMChatCallBacker) {
        self.callBacker = callBacker
    }

    fileprivate func callback(messages: [NIMMessage]) {
        callBacker.callback(messages: messages)
    }
}

public class IMChatManager {
    
    /// 监听路径
    public enum ListenMode {
        /// 接受的消息
        case receive
        /// 发送的消息
        case send
        /// 所有消息
        case all
    }
    
    private(set) var sessionId: String
    private(set) var session: NIMSession
    fileprivate var callabckers: [IMChatHandlerToken] = []
    fileprivate var sendMessageClosures: [IMSimpleMessageClosure] = []
    
    deinit {
        IMEngine.shared.removeChatManager(chatManager: self)
    }
    
    public init(sessionId: String = "00000") {
        self.sessionId = sessionId
        self.session = NIMSession(sessionId, type: .chatroom)
        IMEngine.shared.addChatManager(chatManager: self)
    }
    
    @discardableResult
    func addAttachmentHandler<T: NIMCustomAttachment>(_ type: T.Type, mode: ListenMode = .receive, _ handler: @escaping IMAttachmentClosure<T>) -> IMChatHandlerToken {
        let callbacker = CallbackerNIMCustomAttachment(type: type, mode: mode) {
            handler($0.map { ($0.message, $0.attachment as! T) })
        }
        let token = IMChatHandlerToken(callBacker: callbacker)
        callabckers.append(token)
        return token
    }
    
    func removeHandlerToken(_ token: IMChatHandlerToken) {
        callabckers.removeAll { $0 === token }
    }
    
}

public class IMChatModule {
    public static func register(appKey: String, apnsCername: String? = nil) {
        IMEngine.shared.register(appKey: appKey, apnsCername: apnsCername)
    }
    public static func login(account: String, token: String) {
        IMEngine.shared.login(account: account, token: token)
    }
    public static func registerCustomDecoder(_ decoder: NIMCustomAttachmentCoding) {
        NIMCustomObject.registerCustomDecoder(decoder)
    }
}

class IMEngine: NSObject {
    public private(set) static var shared = IMEngine()
    private override init() {}
    
    // 存储所有的chatManager
    private var chatManagerMap = [String: NSPointerArray]()
    
    fileprivate func register(appKey: String, apnsCername: String? = nil) {
        let option = NIMSDKOption(appKey: appKey)
        option.apnsCername = apnsCername
        NIMSDK.shared().register(with: option)
        NIMSDK.shared().chatManager.add(self)
    }
    
    fileprivate func login(account: String, token: String) {
        NIMSDK.shared().loginManager.login(account, token: token) { error in
            print("----云信登陆 \(String(describing: error))")
        }
    }
}

extension IMEngine: NIMChatManagerDelegate {
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
    
    fileprivate func addChatManager(chatManager: IMChatManager) {
        let sessionId = chatManager.session.sessionId
        var pointers: NSPointerArray! = chatManagerMap[sessionId]
        if pointers == nil {
            pointers = NSPointerArray.weakObjects()
            chatManagerMap[sessionId] = pointers
        }
        let pointer = Unmanaged.passUnretained(chatManager).toOpaque()
        pointers.addPointer(pointer)
    }
    
    fileprivate func removeChatManager(chatManager: IMChatManager) {
        let sessionId = chatManager.session.sessionId
        if let pointers = chatManagerMap[sessionId] {
            if pointers.allObjects.count == 0 {
                chatManagerMap.removeValue(forKey: sessionId)
            }
        }
    }
}

public extension Reactive where Base: IMChatManager {
    func attachmentSignal<T: NIMCustomAttachment>(_ type: T.Type, mode: IMChatManager.ListenMode = .receive) -> Signal<(message: NIMMessage, attachment: T)> {
        weak var base = self.base
        return Observable<(message: NIMMessage, attachment: T)>.create { observer -> Disposable in
            let token = base?.addAttachmentHandler(T.self, mode: mode) {
                $0.forEach {
                    observer.onNext($0)
                }
            }
            return Disposables.create {
                if let token = token {
                    base?.removeHandlerToken(token)
                }
            }
        }.asSignal(onErrorRecover: { _ in
            Signal<(message: NIMMessage, attachment: T)>.never()
        })
    }
}

extension IMChatManager: ReactiveCompatible {}
