//
//  ExampleViewModel.swift
//  swift-study
//
//  Created by 永平 on 2020/12/23.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation

class ExampleViewModel {
    
    struct ExampleListItem {
        var title: String = ""
        var route: String = ""
    }
    class ExampleListModule {
        var title: String = ""
        var items: [ExampleListItem] = []
        convenience init(title: String = "") {
            self.init()
            self.title = title
        }
    }
    
    var modules = [ExampleListModule]()
    
    func configItems() {
        
        // 工具
        var module = ExampleListModule(title: "工具")
        modules.append(module)
        #if canImport(TinyConsole)
        module.items.insert(ExampleListItem(title: "TinyConsole", route: "jackcat://toggleTinyConsole"), at: 0)
        #endif
        
        // 公用组件
        module = ExampleListModule(title: "公用组件")
        modules.append(module)
        module.items = [
            ExampleListItem(title: "JCSNotificationVC",route: "jackcat://runtime/JCSNotificationVC"),
            ExampleListItem(title: "JCSNavigator",route: "jackcat://runtime/JCSNavigatorVC"),
            ExampleListItem(title: "JCS", route: "jackcat://runtime/JCSDemoVC"),
            ExampleListItem(title: "TouchTrough",route: "jackcat://runtime/DemoTouchTroughVC"),
            ExampleListItem(title: "IBDesignableKit",route: "jackcat://sb/IBDesignableKitVC"),
            ExampleListItem(title: "SliderTabControl",route: "jackcat://runtime/SliderTabControlDemoVC"),
            ExampleListItem(title: "SliderPageViewController(未完成)",route: "jackcat://runtime/SliderPageDemoVC"),
            ExampleListItem(title: "ModalTip(未实现)",route: "jackcat://runtime/UIViewController"),
            ExampleListItem(title: "HUD(未实现)",route: "jackcat://runtime/UIViewController"),
        ]
        
        // 直播间相关
        module = ExampleListModule(title: "直播间相关")
        modules.append(module)
        module.items = [
            ExampleListItem(title: "InfiniteScroll(未实现)",route: "jackcat://runtime/UIViewController"),
            ExampleListItem(title: "弹幕(未实现)",route: "jackcat://runtime/UIViewController"),
            ExampleListItem(title: "入场动画队列(未实现)",route: "jackcat://runtime/UIViewController"),
            ExampleListItem(title: "SVGA Queue(未实现)",route: "jackcat://runtime/UIViewController"),
            ExampleListItem(title: "礼物跑道(未实现)",route: "jackcat://runtime/UIViewController"),
            ExampleListItem(title: "评论区",route: "jackcat://runtime/LiveCommentVC"),
        ]
        
        // 业务相关
        module = ExampleListModule(title: "业务相关")
        modules.append(module)
        module.items = [
            ExampleListItem(title: "礼物气泡(样式1)", route: "jackcat://jumpGiftPopVC/1"),
            ExampleListItem(title: "礼物气泡(样式2)", route: "jackcat://jumpGiftPopVC/2"),
            ExampleListItem(title: "Popver",route: "jackcat://sb/PopverViewController"),
            ExampleListItem(title: "富文本",route: "jackcat://sb/RichTextViewController")
        ]
        
        // 加解密
        module = ExampleListModule(title: "加解密")
        modules.append(module)
        module.items = [
            ExampleListItem(title: "Des加密、解密",route: "jackcat://runtime/EncryptViewController")
        ]
        
        // runtime
        module = ExampleListModule(title: "Runtime")
        modules.append(module)
        module.items = [
            ExampleListItem(title: "IMDemo(主工程)",route: "jackcat://runtime/IMDemoVC"),
            ExampleListItem(title: "IMDemo(Order)",route: "jackcat://runtime/OrderVC"),
            ExampleListItem(title: "IMDemo(Person)",route: "jackcat://runtime/PersonVC"),
            ExampleListItem(title: "Modal",route: "jackcat://runtime/ModalDemoViewController"),
            ExampleListItem(title: "PushHalfVC",route: "jackcat://sb/PushHalfVC"),
        ]
        
        // SB
        module = ExampleListModule(title: "Storyboard")
        modules.append(module)
        module.items = [
            ExampleListItem(title: "倒计时", route: "jackcat://sb/CountDownTimerExampleVC"),
            ExampleListItem(title: "UIStackView",route: "jackcat://sb/ExampleStackViewVC"),
            ExampleListItem(title: "RxSwift",route: "jackcat://sb/ExampleRxSwiftVC"),
        ]
    }
}
