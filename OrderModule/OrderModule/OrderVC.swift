//
//  OrderVC.swift
//  Order
//
//  Created by 永平 on 2020/12/24.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

class OrderVC: UIViewController {
    
    let chatManager = IMChatManager(sessionId: "111111")

    override func viewDidLoad() {
        // {"type":2021,"data":{"msgType":100101,"msgJson":{"orderNo":"ORDER000000001","price":400.2}}}
        chatManager.rx.attachmentSignal(IMChatAttachment<OrderVO>.self)
            .emit(onNext: {message in
                print(message.attachment.wrapper.vo?.orderNo)
            })
            .disposing(with: self)
    }
}
