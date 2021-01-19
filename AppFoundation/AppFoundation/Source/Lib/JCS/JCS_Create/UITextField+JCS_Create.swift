//
//  UITextField+JCS_Create.swift
//  AppFoundation
//
//  Created by 永平 on 2021/1/19.
//

import UIKit

public extension UITextField {

    @discardableResult func jcs_text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult func jcs_textColor(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    @discardableResult func jcs_textColor(_ hex: Int, alpha: CGFloat = 1) -> Self {
        textColor = UIColor(hex: hex, alpha: alpha)
        return self
    }
    @discardableResult func jcs_placeholder(_ placeholder: String) -> Self {
        self.placeholder = placeholder
        return self
    }
    

    @discardableResult func jcs_font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    @discardableResult func jcs_font(_ fontSize: CGFloat) -> Self {
        font = UIFont.systemFont(ofSize: fontSize)
        return self
    }
    

    @discardableResult func jcs_textAlignment_Left() -> Self {
        textAlignment = .left
        return self
    }
    @discardableResult func jcs_textAlignment_Right() -> Self {
        textAlignment = .right
        return self
    }
    @discardableResult func jcs_textAlignment_Center() -> Self {
        textAlignment = .center
        return self
    }
    
    @discardableResult func jcs_leftView(_ leftView: UIView) -> Self {
        self.leftView = leftView
        return self
    }
    @discardableResult func jcs_leftViewMode(_ mode: UITextField.ViewMode) -> Self {
        self.leftViewMode = mode
        return self
    }
    @discardableResult func jcs_clearButtonMode(_ mode: UITextField.ViewMode) -> Self {
        self.clearButtonMode = mode
        return self
    }
    @discardableResult func jcs_returnKeyType(_ type: UIReturnKeyType) -> Self {
        self.returnKeyType = type
        return self
    }
    @discardableResult func jcs_keyboardType(_ type: UIKeyboardType) -> Self {
        self.keyboardType = type
        return self
    }
    @discardableResult func jcs_delegate(_ delegate: UITextFieldDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
}
