//
//  IMDemoVC.swift
//  swift-study
//
//  Created by 永平 on 2020/12/24.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit
import NIMSDK

class IMDemoVC: UIViewController {
    let chatManager = IMChatManager(sessionId: "111111")
    
    override func viewDidLoad() {
        chatManager.rx.attachmentSignal(IMChatAttachment<PersonVO>.self)
            .emit(onNext: {message in
                print(message.attachment.wrapper.vo?.nickname)
            })
            .disposing(with: self)

    }
    
}
