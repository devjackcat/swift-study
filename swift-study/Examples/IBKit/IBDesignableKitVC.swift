//
//  IBDesignableKitVC.swift
//  swift-study
//
//  Created by 永平 on 2020/7/7.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit
import AppFoundation

class IBDesignableKitVC: UIViewController {
    
    @IBOutlet var gradientView1: IBGradientView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension IBDesignableKitVC: StoryboardIdentifiable {
    static var storyboardName: String = "IBDesignableKitVC"
    static var storyboardIdentifier: String = "IBDesignableKitVC"
}

