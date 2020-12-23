//
//  NIMDemo.swift
//  swift-study
//
//  Created by 永平 on 2020/12/23.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation
import NIMSDK

class NIMDemo: NSObject, NIMChatManagerDelegate {
    
    func test() {
        register()
        login(account: "jackcat", token: "jackcat-token")
    }
    
    // {"msg":{"msgType":1001,"subType":100101,"msgJson":{"username":"Jack","nickname":"Jack猫","age":22}}}
    
    func onRecvMessages(_ messages: [NIMMessage]) {
//        print("-----\(messages)")
        messages.forEach { (msg) in
            if msg.messageType == .text {
                if let text = msg.text {
                    print("收到消息：" + text)
                }
            }
        }
    }
    
    private func register() {
        NIMSDK.shared().register(with: NIMSDKOption(appKey: "848e7084284a6c8374182ced5a0604a3"))
        NIMSDK.shared().chatManager.add(self)
    }
    
    private func login(account: String, token: String) {
        NIMSDK.shared().loginManager.login(account, token: token) { error in
            print("----云信登陆 \(String(describing: error))")
        }
    }
}
