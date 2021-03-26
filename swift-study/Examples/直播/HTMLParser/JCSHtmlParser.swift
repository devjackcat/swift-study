//
//  JCSHtmlParser.swift
//  swift-study
//
//  Created by 永平 on 2021/3/24.
//  Copyright © 2021 永平. All rights reserved.
//

import UIKit

/**

 ALL IN ONE．period 句号 ,comma 逗号 ：colon 冒号 ；semicolon 分号 !exclamation 惊叹号 question mark 问号 ￣hyphen 连字符 'apostrophe 省略号；所有格符号 —dash 破折号 ‘ ’single quotation marks 单引号...
 
 <h1>Hello World!</h1>
 
 */

class Node { }

class TextNode: Node {
    var text: String?
    init(_ text: String?) {
        self.text = text
    }
}
class TagToken: Node {
    var name: String?
    var attributes: [String: String] = [:]   // 属性
    var children: [Node] = [] // 子节点
}

class JCSHtmlParser {
    
    private var scanner: Scanner?
    
    func parser(_ html: String) -> [Node] {

        let html = """
                    <h1 color="#FF0000">Hello <b>World!</b></h1>
                """
        
        let scanner = Scanner(string: html)
        let nodes = parseNodes(for: scanner)
        
        return []
    }
    
    private func parseNodes(for scanner: Scanner) -> [Node] {
        
        var nodes = [Node]()
        
        var str: NSString?
    
        // 找到标签开头的<
        scanner.scanUpTo("<", into: &str)
        if let str = str {
            nodes.append(TextNode(str as String))
        }
        
        // 标签开头的>
        scanner.scanUpTo(">", into: &str)
        if let str = str {
            nodes.append(TextNode(str as String))
        }
        
        return nodes
    }
    
    private func parseNodeBeginTag(content: String) {
        
    }
    
    private func parseNodeEndTag(content: String) {
        
    }
}

