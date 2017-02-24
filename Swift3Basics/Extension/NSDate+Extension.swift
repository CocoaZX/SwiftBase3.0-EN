//
//  NSDate+Extension.swift
//  SwiftBasics
//
//  Created by 侯伟 on 17/1/11.
//  Copyright © 2017年 侯伟. All rights reserved.
//

import Foundation

// MARK: NSDateFormatter

extension DateFormatter {
    /// 初始化NSDateFormatter时，传递dataFormat属性值
    public convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}

// MARK: Format

extension Date {
    /// 获取NSDateComponents，包含：年 月 日 时 分 秒 周
    public func components(_ unitFlags: NSCalendar.Unit = [.year, .month, .day, .hour, .minute, .second, .weekday]) -> DateComponents {
        let calander = Calendar.current
        return (calander as NSCalendar).components(unitFlags, from: self)
    }
    
    /// 日期格式化成字符串
    public func string(format: String) -> String {
        return DateFormatter(dateFormat: format).string(from: self)
    }
}

extension String {
    /// 从格式化的字符串中创建日期对象
    public func date(format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        return DateFormatter(dateFormat: format).date(from: self)
    }
}

// MARK: Properties

extension Date {
    /// Unix Timestamp: 从格林威治时间1970年01月01日00时00分00秒起至现在的总秒数
    public var unixTimestamp: Int {
        return Int(Date().timeIntervalSince1970)
    }
    
    /// Timestamp: 从格林威治时间1970年01月01日00时00分00秒起至现在的总豪秒数
    public var timestamp: Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
}
