//
//  UIViewControllerFromStoryboardWithArgs.swift
//  HJSwift
//
//  Created by PAN on 2017/11/21.
//  Copyright © 2017年 YR. All rights reserved.
//

import UIKit

public protocol StoryboardIdentifiableWithArgs {
    static var storyboardName: String { get }
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiableWithArgs where Self: UIViewController {
    fileprivate static func instantiateFromStoryboard() -> Self {
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

public protocol StoryboardIdentifiable1Arg: StoryboardIdentifiableWithArgs {
    associatedtype FromStorybardArgType

    func onInitFromStoryboard(_ arg: FromStorybardArgType)
}

public extension StoryboardIdentifiable1Arg where Self: UIViewController {
    static func instantiateFromStoryboard(_ arg: FromStorybardArgType) -> Self {
        let instance = instantiateFromStoryboard()
        instance.onInitFromStoryboard(arg)
        return instance
    }
}

public protocol StoryboardIdentifiable2Arg: StoryboardIdentifiableWithArgs {
    associatedtype FromStorybardArg1Type
    associatedtype FromStorybardArg2Type

    func onInitFromStoryboard(_ arg1: FromStorybardArg1Type, _ arg2: FromStorybardArg2Type)
}

public extension StoryboardIdentifiable2Arg where Self: UIViewController {
    static func instantiateFromStoryboard(_ arg1: FromStorybardArg1Type, _ arg2: FromStorybardArg2Type) -> Self {
        let instance = instantiateFromStoryboard()
        instance.onInitFromStoryboard(arg1, arg2)
        return instance
    }
}

public protocol StoryboardIdentifiable3Arg: StoryboardIdentifiableWithArgs {
    associatedtype FromStorybardArg1Type
    associatedtype FromStorybardArg2Type
    associatedtype FromStorybardArg3Type

    func onInitFromStoryboard(_ arg1: FromStorybardArg1Type, _ arg2: FromStorybardArg2Type, _ arg3: FromStorybardArg3Type)
}

public extension StoryboardIdentifiable3Arg where Self: UIViewController {
    static func instantiateFromStoryboard(_ arg1: FromStorybardArg1Type, _ arg2: FromStorybardArg2Type, _ arg3: FromStorybardArg3Type) -> Self {
        let instance = instantiateFromStoryboard()
        instance.onInitFromStoryboard(arg1, arg2, arg3)
        return instance
    }
}

public protocol StoryboardIdentifiable4Arg: StoryboardIdentifiableWithArgs {
    associatedtype FromStorybardArg1Type
    associatedtype FromStorybardArg2Type
    associatedtype FromStorybardArg3Type
    associatedtype FromStorybardArg4Type

    func onInitFromStoryboard(_ arg1: FromStorybardArg1Type, _ arg2: FromStorybardArg2Type, _ arg3: FromStorybardArg3Type, _ arg4: FromStorybardArg4Type)
}

public extension StoryboardIdentifiable4Arg where Self: UIViewController {
    static func instantiateFromStoryboard(_ arg1: FromStorybardArg1Type, _ arg2: FromStorybardArg2Type, _ arg3: FromStorybardArg3Type, _ arg4: FromStorybardArg4Type) -> Self {
        let instance = instantiateFromStoryboard()
        instance.onInitFromStoryboard(arg1, arg2, arg3, arg4)
        return instance
    }
}

public protocol StoryboardIdentifiable5Arg: StoryboardIdentifiableWithArgs {
    associatedtype FromStorybardArg1Type
    associatedtype FromStorybardArg2Type
    associatedtype FromStorybardArg3Type
    associatedtype FromStorybardArg4Type
    associatedtype FromStorybardArg5Type

    func onInitFromStoryboard(_ arg1: FromStorybardArg1Type, _ arg2: FromStorybardArg2Type, _ arg3: FromStorybardArg3Type, _ arg4: FromStorybardArg4Type, _ arg5: FromStorybardArg5Type)
}

public extension StoryboardIdentifiable5Arg where Self: UIViewController {
    static func instantiateFromStoryboard(_ arg1: FromStorybardArg1Type, _ arg2: FromStorybardArg2Type, _ arg3: FromStorybardArg3Type, _ arg4: FromStorybardArg4Type, _ arg5: FromStorybardArg5Type) -> Self {
        let instance = instantiateFromStoryboard()
        instance.onInitFromStoryboard(arg1, arg2, arg3, arg4, arg5)
        return instance
    }
}
