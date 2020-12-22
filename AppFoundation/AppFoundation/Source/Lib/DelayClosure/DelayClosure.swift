//
//  DelayClosure.swift
//  swift-study
//
//  Created by 永平 on 2020/7/7.
//  Copyright © 2020 永平. All rights reserved.
//

import Foundation

@discardableResult
public func delay(_ time: TimeInterval, task: @escaping () -> Void) -> DispatchWorkItem {
    let workItem = DispatchWorkItem(block: task)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time, execute: workItem)
    return workItem
}
