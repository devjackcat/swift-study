//
//  UIViewControllerFromStoryboard.swift
//  swift-study
//
//  Created by 永平 on 2020/7/7.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardIdentifiable {
    static var storyboardName: String { get }
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static func instantiateFromStoryboard() -> Self {
        let storyboardName = Self.storyboardName
        let identifier = Self.storyboardIdentifier

        if !identifier.isEmpty {
            guard let viewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier) as? Self else {
                fatalError("Couldn't instantiate view controller with: \(storyboardName) - \(identifier) ")
            }
            return viewController
        } else {
            guard let viewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController() as? Self else {
                fatalError("Couldn't instantiate view controller with identifier \(storyboardName)")
            }
            return viewController
        }
    }

    static var storyboardIdentifier: String {
        return ""
    }
}
