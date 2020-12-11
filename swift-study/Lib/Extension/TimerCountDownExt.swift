//
//  TimerTimeDownExt.swift
//  LiveApp
//
//  Created by Cheng.dh on 2020/1/1.
//  Copyright © 2020 YR. All rights reserved.
//

import Foundation
/// 实现计时器倒计时功能

public class CountDownTimer {
    private var timer: Timer?
    public var totalSecond: TimeInterval /// 总倒计时长
    private var repeatInterval: TimeInterval
    private var timeStart: Timer.CountDownClosure<CountDownTimer>? /// 定时器启动
    private var repeatHandler: Timer.CountDownClosure<CountDownTimer> /// 回调
    private var timeOut: Timer.CountDownClosure<CountDownTimer> /// 倒计时结束回调

    public init(total second: TimeInterval,
                repeat interval: TimeInterval = 0.25,
                timeStart timeStartHandler: Timer.CountDownClosure<CountDownTimer>? = nil,
                handler: @escaping Timer.CountDownClosure<CountDownTimer>,
                timeOut timeOutHandler: @escaping Timer.CountDownClosure<CountDownTimer>) {
        totalSecond = second
        repeatInterval = interval
        repeatHandler = handler
        timeOut = timeOutHandler
        timeStart = timeStartHandler
    }

    public func restart() {
        invalidate()
        start()
    }

    private func start() {
        timer = Timer.countDown(totalSecond: totalSecond, interval: repeatInterval, timeStart: { [weak self] in
            self?.timeStart?(self, $1)
        }, handler: { [weak self] in
            self?.repeatHandler(self, $1)
        }, timeOut: { [weak self] in
            self?.timeOut(self, $1)
            self?.timer = nil
        })
    }

    public func invalidate() {
        timer?.invalidate()
        timer = nil
    }

    /// 倒计时结束时间
    public func finishTime() -> Date? {
        timer?.countDownFinishTime()
    }

    deinit {
        invalidate()
    }
}

private var timerFinishTimeKey: Void?

public extension Timer {
    typealias CountDownClosure<T> = (_ timer: T?, _ remainTime: TimeInterval) -> Void
    /// 时间倒计时
    /// - Parameters:
    ///   - millisecond: 倒计时长
    ///   - repeatInterval: 定时器回调间隔
    ///   - timeStartHandler： 定时器启动回调
    ///   - handler: 定时器回调
    ///   - timeOutHandler: 倒计时结束回调
    class func countDown(totalSecond: TimeInterval,
                         interval repeatInterval: TimeInterval = 0.25,
                         timeStart timeStartHandler: CountDownClosure<Timer>? = nil,
                         handler: @escaping CountDownClosure<Timer>,
                         timeOut timeOutHandler: @escaping CountDownClosure<Timer>) -> Timer? {
        if totalSecond <= 0.0 {
            timeStartHandler?(nil, 0.0)
            handler(nil, 0.0)
            timeOutHandler(nil, 0.0)
            return nil
        }
        let finishTime = Date().addingTimeInterval(totalSecond)
        let timer = Timer.schedule(repeatInterval: repeatInterval) { t in
            let remainTime = finishTime.timeIntervalSince(Date())
            if remainTime <= 0.0 {
                handler(t, 0.0)
                timeOutHandler(t, 0.0)
                t?.invalidate()
            } else {
                handler(t, remainTime)
            }
        }
        objc_setAssociatedObject(timer, &timerFinishTimeKey, finishTime, .OBJC_ASSOCIATION_RETAIN)
        timeStartHandler?(timer, totalSecond)
        handler(timer, totalSecond)
        return timer
    }

    /// 定时器结束时间
    func countDownFinishTime() -> Date? {
        return objc_getAssociatedObject(self, &timerFinishTimeKey) as? Date
    }
}
