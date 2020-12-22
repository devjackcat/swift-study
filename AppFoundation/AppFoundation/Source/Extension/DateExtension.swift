//
//  DateExtension.swift
//  ToWatch
//
//  Created by PANGE on 2017/6/8.
//  Copyright © 2017年 PANGE. All rights reserved.
//

import Foundation

public extension Date {
    var pureDay: Date {
        let calendar = NSCalendar.current
        let dateComp = calendar.dateComponents([.year, .month, .day], from: self)
        return calendar.date(from: dateComp)!
    }

    var fullDayString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }

    var longDayString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }

    var dayString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }

    var DayTimeString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }

    func since() -> String {
        let seconds = abs(Date().timeIntervalSince1970 - timeIntervalSince1970)
        if seconds <= 120 {
            return String.localizedStringWithFormat("刚刚")
        }
        let minutes = Int(floor(seconds / 60))
        if minutes <= 60 {
            return String.localizedStringWithFormat("%d分钟前", minutes)
        }
        let hours = minutes / 60
        if hours <= 24 {
            return String.localizedStringWithFormat("%d小时前", hours)
        }
        if hours <= 48 {
            return String.localizedStringWithFormat("昨天")
        }
        let days = hours / 24
        if days <= 30 {
            return String.localizedStringWithFormat("%d天前", days)
        }
        if days <= 14 {
            return String.localizedStringWithFormat("上周", days)
        }
        let months = days / 30
        if months == 1 {
            return String.localizedStringWithFormat("上个月", days)
        }
        if months <= 12 {
            return String.localizedStringWithFormat("%d个月前", months)
        }
        let years = months / 12
        if years == 1 {
            return String.localizedStringWithFormat("去年")
        }
        return String.localizedStringWithFormat("%d年前", years)
    }

    /*
     1、当天发布的评论显示为具体发布时间，如08：34
     2、超出当天（自然日计算），显示为1天前
     3、超出三日（自然日计算），显示为3天前
     */
    func postsCommentSince() -> String {
        let interval = timeIntervalSince1970
        let dayInterval: TimeInterval = 86400
        // 当日 0 点的时间戳
        let currentInterval = floor((interval + 28800) / dayInterval) * dayInterval
        let dif = Date().timeIntervalSince1970 - currentInterval
        if dif < dayInterval {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: self)
        } else if dif < dayInterval * 3 {
            return "1天前"
        } else {
            return "3天前"
        }
    }
}

public enum DateComponentType {
    case second, minute, hour, day, weekday, nthWeekday, week, month, year
}

public extension Date {
    static func weekdaySymbols() -> [String] {
        var weekdaySymbols = DateFormatter().weekdaySymbols!
        weekdaySymbols.append(weekdaySymbols.first!)
        weekdaySymbols.remove(at: 0)
        return weekdaySymbols
    }

    static func getNowHour() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return Int(dateFormatter.string(from: Date())) ?? 0
    }

    func getWeekDay() -> Int {
        let calendar = NSCalendar.current
        let dateComp = calendar.dateComponents([.weekday], from: self)

        // 周日-1 周一-2 ... 周六-7
        let weekday = dateComp.weekday!

        // 周一-0 ... 周六-5 周日-6
        return (weekday - 2 + 7) % 7
    }

//    func getDayTime() -> (year: Int, month: Int, day: Int) {
//        let calendar = NSCalendar.current
//        let dateComp = calendar.dateComponents([.year, .month, .day], from: self)
//        return (dateComp.year ?? 0, dateComp.month ?? 0, dateComp.day ?? 0)
//    }
//
//    func getHmsTime() -> (hour: Int, minute: Int, second: Int) {
//        let calendar = NSCalendar.current
//        let dateComp = calendar.dateComponents([.hour, .minute, .second], from: self)
//        return (dateComp.hour ?? 0, dateComp.minute ?? 0, dateComp.second ?? 0)
//    }

    func adjust(_ component: DateComponentType, offset: Int) -> Date {
        var dateComp = DateComponents()
        switch component {
        case .second:
            dateComp.second = offset
        case .minute:
            dateComp.minute = offset
        case .hour:
            dateComp.hour = offset
        case .day:
            dateComp.day = offset
        case .weekday:
            dateComp.weekday = offset
        case .nthWeekday:
            dateComp.weekdayOrdinal = offset
        case .week:
            dateComp.weekOfYear = offset
        case .month:
            dateComp.month = offset
        case .year:
            dateComp.year = offset
        }
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy'-'MM'-'dd' 'HH':'mm':'ss'"
        formatter.timeZone = TimeZone.current
        return formatter
    }()

    static func dateFromString(_ isoString: String) -> Date? {
        return dateFormatter.date(from: isoString)
    }

    static func stringFromDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
