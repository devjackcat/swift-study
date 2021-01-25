//
//  JCSNavigationViewController.swift
//  JCSNavigationViewController
//
//  Created by abc on 2021/1/23.
//  Copyright © 2021 abc. All rights reserved.
//

import UIKit

private var kNavigatorKey: Int = 0

public extension UIViewController {
    var jcs_navigator: JCSNavigationViewController? {
        return objc_getAssociatedObject(self, &kNavigatorKey) as? JCSNavigationViewController
    }
}

public class JCSNavigationViewController: UIViewController {

//    jcs_navigator分类属性     OK
//    导航栏初始frame及链式方法   OK
//    入场动画及链式方法         OK
//    出场动画及链式方法         OK
//    hidden, show,             OK
//    push,                     OK
//    pop,popToRootVC           OK
//    init(rootVC)              OK
//    distory                   OK
//    push、pop需要考虑控制器生命周期 OK
    
    //    popTo(未支持)
    // 重新设置viewControlers时，需要重置rootVC（未支持）
    
    // present当前Navigator的ViewController
    private weak var hostVC: UIViewController?
    private(set) var viewControlers: [UIViewController] = []
    // Navigator第一个添加控制器
    private var rootVC: UIViewController!
    private var willShowFrame: CGRect {
        CGRect(x: view.bounds.size.width, y: 0, width: view.bounds.size.width, height: view.bounds.size.height)
    }
    private var showingFrame: CGRect {
        CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height)
    }
    private var hiddenFrame: CGRect {
        CGRect(x: -view.bounds.size.width, y: 0, width: view.bounds.size.width, height: view.bounds.size.height)
    }
    // 入场动画
    private var enterAnimateClosure: ((_ contentView: UIView, _ completion: @escaping (() -> Void)) -> Void)?
    // 出场动画
    private var leaveAnimateClosure: ((_ contentView: UIView, _ completion: @escaping (() -> Void)) -> Void)?
    
    public convenience init(rootVC: UIViewController) {
        self.init()
        self.rootVC = rootVC
    }
    
//    deinit {
//        print("--jcs JCSNavigationViewController deinit")
//    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        if enterAnimateClosure == nil {
            enterAnimateClosure = { [weak self] (contentView: UIView, completion: @escaping (() -> Void)) in
                guard let self = self else { return }
                contentView.frame = CGRect(x: 0, y: self.view.bounds.size.height, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
                UIView.animate(withDuration: 0.25, animations: {
                    contentView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height:self.view.bounds.size.height)
                }, completion: { _ in
                    completion()
                })
            }
        }
        if leaveAnimateClosure == nil {
            leaveAnimateClosure = {  [weak self] (contentView: UIView, completion: @escaping (() -> Void)) in
                guard let self = self else { return }
                contentView.frame = CGRect(x: 0, y:0 , width: self.view.bounds.size.width, height: self.view.bounds.size.height)
                UIView.animate(withDuration: 0.25, animations: {
                    contentView.frame = CGRect(x: 0, y: self.view.bounds.size.height, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
                }, completion: { _ in
                    completion()
                })
            }
        }
        
        _pushVC(vc: rootVC)
    }
    
    @discardableResult public func jcs_present(hostVC: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) -> Self{
        
        self.hostVC = hostVC
        
        hostVC.viewWillDisappear(animated)
        
        hostVC.addChild(self)
        hostVC.view.addSubview(view)
        view.frame = hostVC.view.bounds
        enterAnimateClosure?(self.view, {
            hostVC.viewDidDisappear(animated)
            completion?()
        })
        
        return self
    }
    @discardableResult public func jcs_enterAnimate(_ closure: @escaping (_ contentView: UIView, _ completion: @escaping (() -> Void)) -> Void) -> Self{
        enterAnimateClosure = closure
        return self
    }
    @discardableResult public func jcs_leaveAnimate(_ closure: @escaping (_ contentView: UIView, _ completion: @escaping (() -> Void)) -> Void) -> Self{
        leaveAnimateClosure = closure
        return self
    }
    
    @discardableResult public func push(vc: UIViewController, animated: Bool) -> Self{
        
        guard let lastOne = viewControlers.last else { return self }
        
        lastOne.viewWillDisappear(animated)
        
        _pushVC(vc: vc)
        
        if animated {
            vc.view.frame = willShowFrame
            lastOne.view.frame = showingFrame
            
            UIView.animate(withDuration: 0.25) {
                lastOne.viewDidDisappear(animated)
                vc.view.frame = self.showingFrame
                lastOne.view.frame = self.hiddenFrame
            }
        } else {
            lastOne.viewDidDisappear(animated)
            vc.view.frame = self.showingFrame
            lastOne.view.frame = self.hiddenFrame
        }
        
        return self
    }
    @discardableResult public func pop(animated: Bool) -> Self{
        
        if viewControlers.count > 1 { // 堆栈有至少2个，则pop
            let willShowOne = viewControlers[viewControlers.count - 2]
            let willPopOne = viewControlers[viewControlers.count - 1]
            
            self.hostVC?.viewWillAppear(animated)
            
            if animated {
                willShowOne.view.frame = hiddenFrame
                willPopOne.view.frame = showingFrame
                
                UIView.animate(withDuration: 0.25, animations: {
                    willShowOne.view.frame = self.showingFrame
                    willPopOne.view.frame = self.willShowFrame
                }, completion: { _ in
                    self._pop(vc: willPopOne)
                    self.hostVC?.viewDidAppear(animated)
                })
            } else {
                willShowOne.view.frame = self.showingFrame
                willPopOne.view.frame = self.willShowFrame
                self._pop(vc: willPopOne)
                self.hostVC?.viewDidAppear(animated)
            }
        }
        else { // 就一个了，则pop后销毁
//            distory(animated: animated)
        }
        
        return self
    }
    @discardableResult public func popToRoot(animated: Bool) -> Self{
        
        if viewControlers.count > 1 { // 堆栈有至少2个，则pop
            let willPopOne = viewControlers[viewControlers.count - 1]
            
            self.hostVC?.viewWillAppear(animated)
            
            if animated {
                rootVC.view.frame = hiddenFrame
                willPopOne.view.frame = showingFrame
                UIView.animate(withDuration: 0.25, animations: {
                    self.rootVC.view.frame = self.showingFrame
                    willPopOne.view.frame = self.willShowFrame
                }, completion: { _ in
                    self._popToRoot()
                    self.hostVC?.viewDidAppear(animated)
                })
            } else {
                self.rootVC.view.frame = self.showingFrame
                self._popToRoot()
                self.hostVC?.viewDidAppear(animated)
            }
        }
        
        return self
    }
    @discardableResult public func hidden(completion: (() -> Void)? = nil) -> Self{
        leaveAnimateClosure?(self.view, {
            completion?()
        })
        return self
    }
    @discardableResult public func show(completion: (() -> Void)? = nil) -> Self{
        enterAnimateClosure?(self.view, {
            completion?()
        })
        return self
    }
    @discardableResult public func distory(animated: Bool, completion: (() -> Void)? = nil) -> Self{
        hostVC?.viewWillAppear(animated)
        leaveAnimateClosure?(self.view, {
            self.view.removeFromSuperview()
            self.removeFromParent()
            self.hostVC?.viewDidAppear(animated)
            completion?()
        })
        return self
    }
    
    private func _pushVC(vc: UIViewController) {
        injectNavigator(vc: vc)
        
        viewControlers.append(vc)
        addChild(vc)
        
        view.addSubview(vc.view)
        vc.view.frame = showingFrame
        
    }
    private func _pop(vc: UIViewController) {
        _ = self.viewControlers.popLast()
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
    private func _popToRoot() {
        while let lastOne = viewControlers.popLast() {
            if lastOne == self.rootVC {
                break
            }
            lastOne.view.removeFromSuperview()
            lastOne.removeFromParent()
        }
    }
    private func injectNavigator(vc: UIViewController) {
        objc_setAssociatedObject(vc, &kNavigatorKey, self, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
    }
}
