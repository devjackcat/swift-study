//
//  Notification+JCS_Extension.swift
//  AppFoundation
//
//  Created by 永平 on 2021/1/29.
//

import Foundation

private var kNotificationJcsKey: Int = 0
private var actionTargetsKey: Int = 0

private class ActionTargetProxy {
    private var actionClosure: ((Notification) -> Void)?
    @objc func action(_ notify: Notification) {
            actionClosure?(notify)
    }

    func addObserver(name: String, object: Any?, using block: @escaping (Notification) -> Void) {
        actionClosure = block
        NotificationCenter.default.addObserver(self, selector: #selector(action(_:)), name: Notification.Name(name), object: object)
    }
    
//    deinit {
//        print("-----ActionTargetProxy.deinit")
//    }
}

public extension Notification {
    
    @discardableResult static func jcs_addObserver(_ observer: Any, name: String, object: Any? = nil, using block: @escaping (Notification) -> Void)  -> Self.Type {
        var targets = objc_getAssociatedObject(observer, &actionTargetsKey) as? [ActionTargetProxy]
        if targets == nil {
            targets = [ActionTargetProxy]()
        }
        let actionTarget = ActionTargetProxy()
        actionTarget.addObserver(name: name, object: object, using: block)
        
        targets?.append(actionTarget)
        
        objc_setAssociatedObject(observer, &actionTargetsKey, targets, .OBJC_ASSOCIATION_RETAIN)
        return Self.self
    }
    
    @discardableResult static func jcs_addObserver(_ observer: Any, selector: Selector, name: String, object: Any? = nil) -> Self.Type {
        NotificationCenter.default.addObserver(observer, selector: selector, name: Notification.Name(name), object: object)
        return Self.self
    }
    
    @discardableResult static func jcs_addObserver(_ name: String, object: Any? = nil, queue: OperationQueue?, using block: @escaping (Notification) -> Void) -> Self.Type {
        NotificationCenter.default.addObserver(forName: Notification.Name(name), object: object, queue: queue, using: block)
        return Self.self
    }
    
    @discardableResult static func jcs_post(name: String, object: Any? = nil, userInfo: [String: Any]? = nil) -> Self.Type {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: object, userInfo: userInfo)
        return Self.self
    }
    @discardableResult static func jcs_post(notification: Notification) -> Self.Type {
        NotificationCenter.default.post(notification)
        return Self.self
    }
    
    @discardableResult static func jcs_removeObserver(_ observer: Any, name: String, object: Any? = nil) -> Self.Type {
        NotificationCenter.default.removeObserver(observer, name: Notification.Name(name), object: object)
        return Self.self
    }
    @discardableResult static func jcs_removeObserver(_ observer: Any)  -> Self.Type {
        NotificationCenter.default.removeObserver(observer)
        return Self.self
    }
}
