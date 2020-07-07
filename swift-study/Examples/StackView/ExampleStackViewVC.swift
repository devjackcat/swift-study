//
//  ExampleStackViewVC.swift
//  swift-study
//
//  Created by 永平 on 2020/7/6.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

class ExampleStackViewVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ExampleStackViewVC: StoryboardIdentifiable {
    static var storyboardName: String = "ExampleStackViewVC"
    static var storyboardIdentifier: String = "ExampleStackViewVC"
}
