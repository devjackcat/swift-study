//
//  GumboHTMLReader.swift
//  AppFoundation
//
//  Created by 永平 on 2021/3/18.
//

import Foundation
import GumboHTMLTransform
import YYText

class GumboHTMLReader {
    func readHTML2AttributedString(_ html: String, fontSize: CGFloat = 12) -> NSAttributedString? {
        let document = OCGumboDocument(htmlString: html)
        if let document = document, let root = document.rootElement {
            let attributedString = NSMutableAttributedString()
            recuriseAnalysisGumboElement(node: root, attributedString: attributedString, fontSize: fontSize)
            return attributedString as NSAttributedString
        }
        return nil
    }

    private func recuriseAnalysisGumboElement(node: OCGumboNode, attributedString: NSMutableAttributedString, fontSize: CGFloat) {
        for childNode in node.childNodes {
            if let textNode = childNode as? OCGumboText, textNode.nodeName == "#text" {
                let subContent = NSMutableAttributedString(string: textNode.nodeValue ?? "")
                let subRange = NSRange(location: 0, length: subContent.length)
                var reFontSize: CGFloat = fontSize

                // 字体颜色
                if let node = textNode.findLastNode(where: { $0.nodeName == "font" }) as? OCGumboElement, let attributes = node.attributes {
                    for attri in attributes {
                        if let attribute = attri as? OCGumboAttribute, attribute.name == "color" {
                            subContent.addAttributes([.foregroundColor: colorFromString(attribute.value)], range: subRange)
                        }
                        if let attribute = attri as? OCGumboAttribute, attribute.name == "style" {
                            let comps = attribute.value.components(separatedBy: ";").compactMap { part -> (String, String)? in
                                let partData = part.components(separatedBy: ":")
                                if partData.count == 2 {
                                    return (partData[0].trimmingIllegaCharacters(), partData[1].trimmingIllegaCharacters())
                                }
                                return nil
                            }
                            for comp in comps {
                                switch comp.0 {
                                case "text-shadow":
                                    // style="text-shadow: 2pt 2pt 5pt red;"
                                    let params = comp.1.components(separatedBy: " ")
                                    var offset: CGSize?
                                    var radius: Double?
                                    var color: UIColor?
                                    if params.count == 3 {
                                        offset = CGSize(width: params[0].ptValue, height: params[1].ptValue)
                                        radius = 1
                                        color = colorFromString(params[2])
                                    }
                                    if params.count == 4 {
                                        offset = CGSize(width: params[0].ptValue, height: params[1].ptValue)
                                        radius = params[2].ptValue
                                        color = colorFromString(params[3])
                                    }
                                    if let offset = offset, let radius = radius, let color = color {
                                        let textShadow = YYTextShadow()
                                        textShadow.color = color
                                        textShadow.offset = offset
                                        textShadow.radius = CGFloat(radius)
                                        subContent.yy_setTextShadow(textShadow, range: subRange)
                                    }
                                case "font-size":
                                    let size = comp.1.ptValue
                                    if size > 0 {
                                        reFontSize = CGFloat(size)
                                        subContent.addAttributes([.font: UIFont.systemFont(ofSize: reFontSize, weight: .regular)], range: subRange)
                                    }
                                default:
                                    break
                                }
                            }
                        }
                    }
                }
                // 下划线
                if textNode.findLastNode(where: { $0.nodeName == "u" }) != nil {
                    subContent.addAttributes([.underlineStyle: 1], range: subRange)
                }
                // 粗体
                if textNode.findLastNode(where: { $0.nodeName == "b" || $0.nodeName == "strong" }) != nil {
                    subContent.addAttributes([.font: UIFont.systemFont(ofSize: reFontSize, weight: .heavy)], range: subRange)
                }
                // 删除线
                if textNode.findLastNode(where: { $0.nodeName == "strike" }) != nil {
                    subContent.addAttributes([.strikethroughStyle: 1], range: subRange)
                }
                // 斜体
                if textNode.findLastNode(where: { $0.nodeName == "em" || $0.nodeName == "i" }) != nil {
                    subContent.addAttributes([.obliqueness: 0.2], range: subRange)
                }
                // 超链接
                if let node = textNode.findLastNode(where: { $0.nodeName == "a" }) as? OCGumboElement,
                   let attributes = node.attributes,
                   let href = attributes.compactMap({ $0 as? OCGumboAttribute }).first(where: { $0.name == "href" })?.value
                {
                    let highlight = YYTextHighlight(backgroundColor: .clear)
                    highlight.userInfo = ["href": href]
                    subContent.yy_setTextHighlight(highlight, range: subRange)
                    subContent.addAttributes([.underlineStyle: 1], range: subRange)
                }
                attributedString.append(subContent)
            }
            if let element = childNode as? OCGumboElement {
                // 支持段落和换行（段落未详解）
                if element.nodeName == "br" || element.nodeName == "p" {
                    attributedString.append(NSAttributedString(string: "\n"))
                }
                recuriseAnalysisGumboElement(node: element, attributedString: attributedString, fontSize: fontSize)
            }
        }
    }
}

private func colorFromString(_ string: String) -> UIColor {
    var hexString = string
    if let tryColorNameHex = HTMLColorNames[string.lowercased()] {
        hexString = tryColorNameHex
    }
    return UIColor(hexString: hexString)
}

private extension OCGumboNode {
    func findLastNode(where predicate: (OCGumboNode) -> Bool) -> OCGumboNode? {
        var node: OCGumboNode? = self
        while node != nil {
            if let node = node, predicate(node) {
                return node
            }
            node = node?.parent
        }
        return nil
    }
}

private extension String {
    func trimmingIllegaCharacters() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var ptValue: Double {
        let number = (trimmingCharacters(in: NSCharacterSet.decimalDigits.inverted) as NSString).doubleValue
        if hasSuffix("px") {
            return number / Double(UIScreen.main.scale)
        }
        return number
    }
}

let HTMLColorNames: [String: String] =
[
  "aliceblue": "#f0f8ff",
  "antiquewhite": "#faebd7",
  "aqua": "#00ffff",
  "aquamarine": "#7fffd4",
  "azure": "#f0ffff",
  "beige": "#f5f5dc",
  "bisque": "#ffe4c4",
  "black": "#000000",
  "blanchedalmond": "#ffebcd",
  "blue": "#0000ff",
  "blueviolet": "#8a2be2",
  "brown": "#a52a2a",
  "burlywood": "#deb887",
  "cadetblue": "#5f9ea0",
  "chartreuse": "#7fff00",
  "chocolate": "#d2691e",
  "coral": "#ff7f50",
  "cornflowerblue": "#6495ed",
  "cornsilk": "#fff8dc",
  "crimson": "#dc143c",
  "cyan": "#00ffff",
  "darkblue": "#00008b",
  "darkcyan": "#008b8b",
  "darkgoldenrod": "#b8860b",
  "darkgray": "#a9a9a9",
  "darkgreen": "#006400",
  "darkgrey": "#a9a9a9",
  "darkkhaki": "#bdb76b",
  "darkmagenta": "#8b008b",
  "darkolivegreen": "#556b2f",
  "darkorange": "#ff8c00",
  "darkorchid": "#9932cc",
  "darkred": "#8b0000",
  "darksalmon": "#e9967a",
  "darkseagreen": "#8fbc8f",
  "darkslateblue": "#483d8b",
  "darkslategray": "#2f4f4f",
  "darkslategrey": "#2f4f4f",
  "darkturquoise": "#00ced1",
  "darkviolet": "#9400d3",
  "deeppink": "#ff1493",
  "deepskyblue": "#00bfff",
  "dimgray": "#696969",
  "dimgrey": "#696969",
  "dodgerblue": "#1e90ff",
  "firebrick": "#b22222",
  "floralwhite": "#fffaf0",
  "forestgreen": "#228b22",
  "fuchsia": "#ff00ff",
  "gainsboro": "#dcdcdc",
  "ghostwhite": "#f8f8ff",
  "goldenrod": "#daa520",
  "gold": "#ffd700",
  "gray": "#808080",
  "green": "#008000",
  "greenyellow": "#adff2f",
  "grey": "#808080",
  "honeydew": "#f0fff0",
  "hotpink": "#ff69b4",
  "indianred": "#cd5c5c",
  "indigo": "#4b0082",
  "ivory": "#fffff0",
  "khaki": "#f0e68c",
  "lavenderblush": "#fff0f5",
  "lavender": "#e6e6fa",
  "lawngreen": "#7cfc00",
  "lemonchiffon": "#fffacd",
  "lightblue": "#add8e6",
  "lightcoral": "#f08080",
  "lightcyan": "#e0ffff",
  "lightgoldenrodyellow": "#fafad2",
  "lightgray": "#d3d3d3",
  "lightgreen": "#90ee90",
  "lightgrey": "#d3d3d3",
  "lightpink": "#ffb6c1",
  "lightsalmon": "#ffa07a",
  "lightseagreen": "#20b2aa",
  "lightskyblue": "#87cefa",
  "lightslategray": "#778899",
  "lightslategrey": "#778899",
  "lightsteelblue": "#b0c4de",
  "lightyellow": "#ffffe0",
  "lime": "#00ff00",
  "limegreen": "#32cd32",
  "linen": "#faf0e6",
  "magenta": "#ff00ff",
  "maroon": "#800000",
  "mediumaquamarine": "#66cdaa",
  "mediumblue": "#0000cd",
  "mediumorchid": "#ba55d3",
  "mediumpurple": "#9370db",
  "mediumseagreen": "#3cb371",
  "mediumslateblue": "#7b68ee",
  "mediumspringgreen": "#00fa9a",
  "mediumturquoise": "#48d1cc",
  "mediumvioletred": "#c71585",
  "midnightblue": "#191970",
  "mintcream": "#f5fffa",
  "mistyrose": "#ffe4e1",
  "moccasin": "#ffe4b5",
  "navajowhite": "#ffdead",
  "navy": "#000080",
  "oldlace": "#fdf5e6",
  "olive": "#808000",
  "olivedrab": "#6b8e23",
  "orange": "#ffa500",
  "orangered": "#ff4500",
  "orchid": "#da70d6",
  "palegoldenrod": "#eee8aa",
  "palegreen": "#98fb98",
  "paleturquoise": "#afeeee",
  "palevioletred": "#db7093",
  "papayawhip": "#ffefd5",
  "peachpuff": "#ffdab9",
  "peru": "#cd853f",
  "pink": "#ffc0cb",
  "plum": "#dda0dd",
  "powderblue": "#b0e0e6",
  "purple": "#800080",
  "rebeccapurple": "#663399",
  "red": "#ff0000",
  "rosybrown": "#bc8f8f",
  "royalblue": "#4169e1",
  "saddlebrown": "#8b4513",
  "salmon": "#fa8072",
  "sandybrown": "#f4a460",
  "seagreen": "#2e8b57",
  "seashell": "#fff5ee",
  "sienna": "#a0522d",
  "silver": "#c0c0c0",
  "skyblue": "#87ceeb",
  "slateblue": "#6a5acd",
  "slategray": "#708090",
  "slategrey": "#708090",
  "snow": "#fffafa",
  "springgreen": "#00ff7f",
  "steelblue": "#4682b4",
  "tan": "#d2b48c",
  "teal": "#008080",
  "thistle": "#d8bfd8",
  "tomato": "#ff6347",
  "turquoise": "#40e0d0",
  "violet": "#ee82ee",
  "wheat": "#f5deb3",
  "white": "#ffffff",
  "whitesmoke": "#f5f5f5",
  "yellow": "#ffff00",
  "yellowgreen": "#9acd32"
]
