//
//  UIViewFromNib.swift
//  swift-study
//
//  Created by 永平 on 2020/5/22.
//  Copyright © 2020 永平. All rights reserved.
//

import UIKit

public extension UIView {
    class func fromNib(_ nibNameOrNil: String? = nil) -> Self {
        return fromNib(nibNameOrNil, type: self)!
    }

    class func fromNib<T: UIView>(_ nibNameOrNil: String? = nil, owner: Any? = nil, type: T.Type) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = nibName
        }
        if let nibViews = Bundle.main.loadNibNamed(name, owner: owner, options: nil) {
            for v in nibViews {
                if let tog = v as? T {
                    view = tog
                }
            }
        }
        return view
    }

    class var nibName: String {
        let name = "\(self)".components(separatedBy: ".").first ?? ""
        return name
    }

    class var nib: UINib? {
        if let _ = Bundle.main.path(forResource: nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
}

