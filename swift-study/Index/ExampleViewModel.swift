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
     
    var demoList: [ExampleListItem] = []
    
    init() {
        
        demoList = [
            ExampleListItem(title: "礼物气泡(样式1)", route: "jackcat://jumpGiftPopVC/1"),
            ExampleListItem(title: "礼物气泡(样式2)", route: "jackcat://jumpGiftPopVC/2"),
            
            // runtime
            ExampleListItem(title: "JCSNotificationVC",route: "jackcat://runtime/JCSNotificationVC"),
            ExampleListItem(title: "JCSNavigator",route: "jackcat://runtime/JCSNavigatorVC"),
            ExampleListItem(title: "IMDemo(主工程)",route: "jackcat://runtime/IMDemoVC"),
            ExampleListItem(title: "IMDemo(Order)",route: "jackcat://runtime/OrderVC"),
            ExampleListItem(title: "IMDemo(Person)",route: "jackcat://runtime/PersonVC"),
            ExampleListItem(title: "JCS", route: "jackcat://runtime/JCSDemoVC"),
            ExampleListItem(title: "Modal",route: "jackcat://runtime/ModalDemoViewController"),
            ExampleListItem(title: "TouchTrough",route: "jackcat://runtime/DemoTouchTroughVC"),
            ExampleListItem(title: "PushHalfVC",route: "jackcat://sb/PushHalfVC"),
            
            // sb
            ExampleListItem(title: "倒计时", route: "jackcat://sb/CountDownTimerExampleVC"),
            ExampleListItem(title: "UIStackView",route: "jackcat://sb/ExampleStackViewVC"),
            ExampleListItem(title: "RxSwift",route: "jackcat://sb/ExampleRxSwiftVC"),
            ExampleListItem(title: "IBDesignableKit",route: "jackcat://sb/IBDesignableKitVC"),
            ExampleListItem(title: "富文本",route: "jackcat://sb/RichTextViewController"),
            ExampleListItem(title: "Popver",route: "jackcat://sb/PopverViewController"),
            
        ]
        
        #if canImport(TinyConsole)
        demoList.insert(ExampleListItem(title: "TinyConsole", route: "jackcat://toggleTinyConsole"), at: 0)
        #endif
    }
}
