//
//  PersonVC.swift
//  PersonModule
//
//  Created by 永平 on 2020/12/24.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

class PersonVC: UIViewController {
    let chatManager = IMChatManager(sessionId: "111111")
    
    override func viewDidLoad() {
        view.jcs_backgroundColor_White()
        // {"type":2020,"data":{"msgType":100101,"msgJson":{"username":"Jack","nickname":"Jack猫","age":22}}}
        chatManager.rx.attachmentSignal(IMChatAttachment<PersonVO>.self)
            .emit(onNext: {message in
                print(message.attachment.wrapper.vo?.nickname)
            })
            .disposing(with: self)
    }
}
