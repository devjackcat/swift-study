//
//  JCSOperators.swift
//  LiveApp
//
//  Created by 永平 on 2020/6/30.
//  Copyright © 2020 YR. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

precedencegroup JCSLeftFlowPrecedence {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
}

infix operator >>>: JCSLeftFlowPrecedence

// MARK: - Observable >>>

@discardableResult
public func >>> <T>(left: Observable<T>, right: inout Observable<T>?) -> Observable<T> { right = left; return left }
@discardableResult
public func >>> <T>(left: Observable<T>, right: inout Observable<T>) -> Observable<T> { right = left; return left }

// MARK: - Bool >>>

@discardableResult
public func >>> (left: Bool, right: inout Bool?) -> Bool { right = left; return left }
@discardableResult
public func >>> (left: Bool, right: inout Bool) -> Bool { right = left; return left }

// MARK: - String >>>

@discardableResult
public func >>> (left: String, right: inout String?) -> String { right = left; return left }
@discardableResult
public func >>> (left: String, right: inout String) -> String { right = left; return left }

// MARK: - UIColor >>>

@discardableResult
public func >>> (left: UIColor, right: inout UIColor?) -> UIColor { right = left; return left }
@discardableResult
public func >>> (left: UIColor, right: inout UIColor) -> UIColor { right = left; return left }

// MARK: - Number >>>

@discardableResult
public func >>> (left: Int, right: inout Int) -> Int {
    right = left
    return left
}

@discardableResult
public func >>> (left: Float, right: inout Float) -> Float { right = left; return left }
@discardableResult
public func >>> (left: Float, right: inout Float?) -> Float { right = left; return left }
@discardableResult
public func >>> (left: CGFloat, right: inout CGFloat) -> CGFloat { right = left; return left }
@discardableResult
public func >>> (left: CGFloat, right: inout CGFloat?) -> CGFloat { right = left; return left }
@discardableResult
public func >>> (left: Double, right: inout Double) -> Double { right = left; return left }
@discardableResult
public func >>> (left: Double, right: inout Double?) -> Double { right = left; return left }

// MARK: - 通用 >>>

// @discardableResult
// func >>> <T> (left: T,right: inout T?) -> T {
//    right = left
//    return left
// }
// @discardableResult
// func >>> <T> (left: T,right: inout T) -> T {
//    right = left
//    return left
// }
