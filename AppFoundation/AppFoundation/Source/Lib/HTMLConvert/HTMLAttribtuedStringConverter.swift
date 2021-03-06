//
//  HTMLAttribtuedStringConverter.swift
//  AppFoundation
//
//  Created by 永平 on 2021/3/18.
//

import Foundation
import UIKit

/// 只处理颜色标签
public class HTMLAttribtuedStringConverter {
    public class func attributedString2HTML(_ attrs: NSAttributedString) -> String {
        let html = NSMutableString(string: attrs.string)
        attrs.enumerateAttribute(NSAttributedString.Key.foregroundColor, in: NSRange(location: 0, length: html.length), options: .reverse) { color, range, _ in
            if let color = color as? UIColor {
                html.insert("</font>", at: range.location + range.length)
                html.insert("<font style=\"color:\(color.toHexString())\">", at: range.location)
            }
        }
        return html as String
    }

    /// 尽量放子线程
    /// - Parameter html:  HTML
    /// - Returns: NSAttributedString (with YYText)
    public class func HTML2AttributedString(_ html: String, fontSize: CGFloat = 12) -> NSAttributedString? {
        return GumboHTMLReader().readHTML2AttributedString(html, fontSize: fontSize)
    }
}
