//
//  IMChatManager.swift
//  IMChat
//
//  Created by 永平 on 2020/12/24.
//

import Foundation
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

    func callback(messages: [NIMMessage]) {
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
    var callabckers: [IMChatHandlerToken] = []
    var sendMessageClosures: [IMSimpleMessageClosure] = []
    
    deinit {
        IMChatEngine.shared.removeChatManager(chatManager: self)
    }
    
    public init(sessionId: String = "00000") {
        self.sessionId = sessionId
        self.session = NIMSession(sessionId, type: .chatroom)
        IMChatEngine.shared.addChatManager(chatManager: self)
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

