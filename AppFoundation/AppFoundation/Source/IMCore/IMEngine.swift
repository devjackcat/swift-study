//
//  IMEngine.swift
//  AppFoundation
//
//  Created by 永平 on 2020/12/24.
//

import UIKit
import NIMSDK

public class IMListener {
    let receive: ((String) -> Void)
    public init(receive: @escaping ((String) -> Void)) {
        self.receive = receive
    }
}

public class IMEngine: NSObject, NIMChatManagerDelegate {
    public private(set) static var shared = IMEngine()
    private override init() {}
    
    private var listeners: [IMListener] = []
    
    public func onRecvMessages(_ messages: [NIMMessage]) {
        messages.forEach { (msg) in
            if msg.messageType == .text {
                if let text = msg.text {
//                    print("收到消息：" + text)
                    listeners.forEach { $0.receive(text) }
                }
            }
        }
    }
    
    public func register(appKey: String, apnsCername: String? = nil) {
        let option = NIMSDKOption(appKey: appKey)
        option.apnsCername = apnsCername
        NIMSDK.shared().register(with: option)
        NIMSDK.shared().chatManager.add(self)
    }
    
    public func login(account: String, token: String) {
        NIMSDK.shared().loginManager.login(account, token: token) { error in
            print("----云信登陆 \(String(describing: error))")
        }
    }
    
    public func addMessageListener(listener: IMListener) {
//        if listeners.contains(where: <#T##(IMListener) throws -> Bool#>)
        listeners.append(listener)
    }
}
