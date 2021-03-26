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

//enum Word {
//    case whitespace              /// 空格
//    case angleBracketsLeft      /// <
//    case angleBracketsRight     /// >
//    case character(_ scalar: Unicode.Scalar)  /// 字符
//    case slant                  /// 斜杠"/"
//}
//enum TokenType {
//    case unknow
//    case h1
//    case h2
//    case font
//    case br
//    case text
//}
//class Token {
//    var type: TokenType = .unknow
//    var children: [Token] = []
//}
//
//class JCSHtmlParser {
//    static func parser(_ html: String) -> [Word] {
//
//        let html = """
//                    <h1 color="#FF0000">Hello <b>World!</b></h1>
//                """
//        let words = Parser.createWords(html)
//        let tokens = Tokenizer().createTokens(words)
//        
//        return words
//    }
//}
//
//class Tokenizer {
//    
//    private class _Token { }
//    
//    private class _TextToken: _Token {
//        var content: [Unicode.Scalar] = []  // 内容
//        init(_ scalar: Unicode.Scalar) {
//            content.append(scalar)
//        }
//    }
//    private class _NodeToken: _Token {
//        enum _NodeTokenComp {
//            case unknow
//            case start(_ scalars: [Unicode.Scalar])
//            case attr(_ name: [Unicode.Scalar], _ value: [[Unicode.Scalar]])
//            case children
//            case end(_ scalars: [Unicode.Scalar])
//        }
//        var currentComp: _NodeTokenComp = .unknow
//        var name: String?
//        var attributes: [String: String] = [:]   // 属性
//        var children: [_Token] = [] // 子节点
//    }
//    
//    private var _tokens: [_Token] = []
//    private var _lastToken: _Token?
//    
//    func createTokens(_ words: [Word]) -> [Token] {
//        
//        _tokens = []
//        _lastToken = nil
//        
//        words.forEach { word in
//            switch word {
//            case .angleBracketsLeft:
//                _handleAngleBracketsLeft(word)
//                
//            case .angleBracketsRight:
//                _handleAngleBracketsRight(word)
//                
//            case let .character(scalar):
//                _handleCharacter(scalar)
//                
//            case .whitespace:
//                _handleWhitespace()
//                
//            case .slant:
//                _handleSlant()
//                
//            }
//        }
//        
//        var tokens = [Token]()
//        return tokens
//    }
//    
//    private func _handleAngleBracketsLeft(_ word: Word) {
//        if let lastToken = _lastToken {
////            lastToken
//        } else {
//            _lastToken = _NodeToken()
//        }
//    }
//    private func _handleAngleBracketsRight(_ word: Word) {
//        if let lastToken = _lastToken, let nodeToken = lastToken as? _NodeToken { // _NodeToken only
//            switch nodeToken.currentComp {
//            case .unknow:
//                // 错误
//                break
//            case let .start(scalars):
//                nodeToken.currentComp = .start(scalars + [scalar])
//            case .attr(_, _):
//                break
//            case .children:
//                // 错误：Text遇到了">"
//                break
//            case .end(_):
//                break
//            }
//        } else {
//            // 错误：Text遇到了">"
//        }
//    }
//    private func _handleCharacter(_ scalar: Unicode.Scalar) {
//        if let lastToken = _lastToken {
//            if let textToken = lastToken as? _TextToken { // _TextToken
//                textToken.content.append(scalar)
//            } else if let nodeToken = lastToken as? _NodeToken { // _NodeToken
//                switch nodeToken.currentComp {
//                case .unknow:
//                    nodeToken.currentComp = .start([scalar])
//                case let .start(scalars):
//                    nodeToken.currentComp = .start(scalars + [scalar])
//                case .attr(_, _):
//                    break
//                case .children:
//                    break
//                case .end(_):
//                    break
//                }
//            }
//        } else {
//            _lastToken = _TextToken(scalar)
//        }
//    }
//    private func _handleWhitespace() {
//        
//    }
//    private func _handleSlant() {
//        
//    }
//    
//    private func _finishToken(_ token: _Token) {
//        
//    }
//}
//
//class Parser {
//    
//    private struct S {
//        static let whitespace = CharacterSet(charactersIn: " ")             /// 空格
//        static let angleBracketsLeft = CharacterSet(charactersIn: "<")     /// <
//        static let angleBracketsRight = CharacterSet(charactersIn: ">")  /// >
//        static let slant = CharacterSet(charactersIn: "/")              /// 斜杠"/"
//    }
//    
//    static func createWords(_ html: String) -> [Word] {
//        var words = [Word]()
//        html.unicodeScalars.forEach { (scalar) in
//            if let word = createWord(scalar) {
//                words.append(word)
//            }
//        }
//        return words
//    }
//    static func createWord(_ scalar: Unicode.Scalar) -> Word? {
//        if S.whitespace.contains(scalar) { return .whitespace }
//        else if S.angleBracketsLeft.contains(scalar) { return .angleBracketsLeft }
//        else if S.angleBracketsRight.contains(scalar) { return .angleBracketsRight }
//        else if S.slant.contains(scalar) { return .slant }
//        else { return .character(scalar) }
//    }
//}

