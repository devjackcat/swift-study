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
    
    let demoList: [ExampleListItem] = [
        ExampleListItem(title: "TinyConsole", route: "jackcat://toggleTinyConsole"),
        ExampleListItem(title: "礼物气泡(样式1)", route: "jackcat://jumpGiftPopVC/1"),
        ExampleListItem(title: "礼物气泡(样式2)", route: "jackcat://jumpGiftPopVC/2"),
        ExampleListItem(title: "倒计时", route: "jackcat://push/CountDownTimerExampleVC"),
        ExampleListItem(title: "UIStackView",route: "jackcat://push/ExampleStackViewVC"),
        ExampleListItem(title: "RxSwift",route: "jackcat://push/ExampleRxSwiftVC"),
        ExampleListItem(title: "IBDesignableKit",route: "jackcat://push/IBDesignableKitVC"),
        ExampleListItem(title: "富文本",route: "jackcat://push/RichTextViewController"),
        ExampleListItem(title: "Popver",route: "jackcat://push/PopverViewController"),
        ExampleListItem(title: "Modal",route: "jackcat://push/ModalDemoViewController"),
        ExampleListItem(title: "TouchTrough",route: "jackcat://push/DemoTouchTroughVC"),
    ]
    
}
