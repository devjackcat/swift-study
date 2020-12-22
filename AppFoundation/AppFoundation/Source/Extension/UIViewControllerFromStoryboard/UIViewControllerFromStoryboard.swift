//
//  UIViewControllerFromStoryboard.swift
//  HJSwift
//
//  Created by PAN on 2017/11/21.
//  Copyright © 2017年 YR. All rights reserved.
//

import Foundation
import UIKit

public protocol StoryboardIdentifiable {
    static var storyboardName: String { get }
    static var storyboardIdentifier: String { get }
}

public extension StoryboardIdentifiable where Self: UIViewController {
    static func instantiateFromStoryboard() -> Self {
        let storyboardName = Self.storyboardName
        let identifier = Self.storyboardIdentifier

        if !identifier.isEmpty {
            guard let viewController = UIStoryboard(name: storyboardName, bundle: Bundle(for: Self.self)).instantiateViewController(withIdentifier: identifier) as? Self else {
                fatalError("Couldn't instantiate view controller with: \(storyboardName) - \(identifier) ")
            }
            return viewController
        } else {
            guard let viewController = UIStoryboard(name: storyboardName, bundle: Bundle(for: Self.self)).instantiateInitialViewController() as? Self else {
                fatalError("Couldn't instantiate view controller with identifier \(storyboardName)")
            }
            return viewController
        }
    }

    static var storyboardIdentifier: String {
        return ""
    }
}
