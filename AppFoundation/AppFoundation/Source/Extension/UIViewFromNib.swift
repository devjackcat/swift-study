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
        return fromNib(nibNameOrNil: nibNameOrNil)!
    }

    class func fromNib(nibNameOrNil: String?, bundle: Bundle? = nil, owner: Any? = nil, index: Int? = nil) -> Self? {
        var view: Self?
        let name: String
        if let _nibName = nibNameOrNil {
            name = _nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = nibName
        }
        var nibViews: [Any]?
        let bundles: [Bundle?] = [bundle, Bundle.main, Bundle(for: Self.self)]
        for bundle in bundles.compactMap({ $0 }) {
            if let temp = loadNibs(bundle: bundle, name: name, owner: owner, options: nil) {
                nibViews = temp
                break
            }
        }
        if let nibViews = nibViews {
            if let index = index {
                view = nibViews[index] as? Self
            } else {
                view = nibViews.first(where: { $0 is Self }) as? Self
            }
        }
        return view
    }

    class var nibName: String {
        let name = "\(self)".components(separatedBy: ".").first ?? ""
        return name
    }

    class var nib: UINib? {
        if let _ = Bundle(for: Self.self).path(forResource: nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
}

private func loadNibs(bundle: Bundle, name: String, owner: Any?, options: [UINib.OptionsKey: Any]?) -> [Any]? {
    let xibNames: [String]
    switch UIDevice.current.userInterfaceIdiom {
    case .phone:
        xibNames = ["\(name)~iphone", name]
    case .pad:
        xibNames = ["\(name)~ipad", name]
    default:
        xibNames = [name]
    }
    if let xibName = xibNames.first(where: { name -> Bool in
        if let path = bundle.path(forResource: name, ofType: ".nib") {
            return FileManager.default.fileExists(atPath: path)
        }
        return false
    }) {
        return bundle.loadNibNamed(xibName, owner: owner, options: options)
    }
    return nil
}
