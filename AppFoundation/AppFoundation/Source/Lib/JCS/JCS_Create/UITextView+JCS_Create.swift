//
//  UITextView+JCS_Create.swift
//  AppFoundation
//
//  Created by 永平 on 2021/1/19.
//

import UIKit

public extension UITextView {
    
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
    
    
    @discardableResult func jcs_returnKeyType(_ type: UIReturnKeyType) -> Self {
        self.returnKeyType = type
        return self
    }
    @discardableResult func jcs_keyboardType(_ type: UIKeyboardType) -> Self {
        self.keyboardType = type
        return self
    }
    @discardableResult func jcs_delegate(_ delegate: UITextViewDelegate) -> Self {
        self.delegate = delegate
        return self
    }
    
}
