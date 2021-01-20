//
//  __AppSetup.swift
//  swift-study
//
//  Created by 永平 on 2020/12/24.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation

class AppSetup {
    static let shared = AppSetup()
    private init() {}
    
    func setup() {
        // 加载路由
        loadRoutes()
        // 注册三方库
        registerThirdParty()
        
        // 加载需要runtime创建的class
        JCSRuntime.loadRuntimeClasses()
    }
    
    private func loadRoutes() {
        JCRouter.loadRoutes(router: XXRouter.self)
        JCRouter.loadRoutes(router: ExampleRouter.self)
        JCRouter.loadRoutes(router: OrderRouter.self)
    }
    
    private func registerThirdParty() {
        IMChatModule.register(appKey: "848e7084284a6c8374182ced5a0604a3")
        IMChatModule.login(account: "jackcat", token: "jackcat-token")
        // 自定义消息解析
        IMChatModule.registerCustomDecoder([
            OrderAttachmentDecoder(),
            PersonAttachmentDecoder(),
            MainAttachmentDecoder()
        ])
    }
}
