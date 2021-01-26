//
//  UIAlertController+JCS_Create.swift
//  yeyan
//
//  Created by 永平 on 2021/1/22.
//  Copyright © 2021 Zhejiang DianNi Network Technology Co.,Ltd. All rights reserved.
//

import UIKit

public extension UIAlertController {
    @discardableResult func jcs_addAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        addAction(UIAlertAction(title: title, style: style, handler: handler))
        return self
    }
    @discardableResult func jcs_addTextField(configurationHandler: ((UITextField) -> Void)? = nil) -> Self {
        addTextField(configurationHandler: configurationHandler)
        return self
    }
    @discardableResult func jcs_preferredAction(_ action: UIAlertAction?) -> Self {
        self.preferredAction = action
        return self
    }
    @discardableResult func jcs_title(_ title: String?) -> Self {
        self.title = title
        return self
    }
    @discardableResult func jcs_message(_ message: String?) -> Self {
        self.message = message
        return self
    }
    @discardableResult func jcs_show(parentVC: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) -> Self {
        parentVC.present(self, animated: animated, completion: completion)
        return self
    }
}
