//
//  NSDate+Extension.swift
//
//  Created by YH_O on 2017/3/13.
//  Copyright © 2017年 OYH. All rights reserved.
//

import Foundation

extension Date {
    
    public func convertedDateComponents() -> DateComponents {
        let calendar = Calendar.current
        let calendarUnit: Set = [Calendar.Component.year, .month, .day, .hour, .minute, .second, .weekday]
        let dateCmps = calendar.dateComponents(calendarUnit, from: self)
        return dateCmps
    }
    
    // 两时间相隔天数
    public static func days(seconds: String, toSeconds: String) -> Int {
        let time = abs(Double(toSeconds)! - Double(seconds)!)
        return Int(ceil(time / (60.0 * 60.0 * 24.0)))
    }
    
    // MARK: - 获取当前时间
    public static func currentDateStr() -> String {
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let dateStr = dateFormatter.string(from: currentDate)
        
        return dateStr
    }
    
    /** 时间戳转字符串 */
    public static func dateWithSeconds(totalSeconds: TimeInterval) -> String {
        
        let date = Date.init(timeIntervalSince1970: totalSeconds)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return dateFormatter.string(from: date)
    }
    /** 时间戳转字符串 + 格式化字符串 */
    public static func dateWithSeconds(totalSeconds: TimeInterval, formatter: String) -> String {
        
        let date = Date.init(timeIntervalSince1970: totalSeconds)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        
        return dateFormatter.string(from: date)
    }
    /** 字符串转时间戳 */
    public static func timestampFromString(dateStr: String, format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let locale = Locale.init(identifier: "zh_CN")
        dateFormatter.locale = locale
        let date = dateFormatter.date(from: dateStr)
        
        let timestamp = String.init(format: "%ld", Int((date?.timeIntervalSince1970)!))
        
        return timestamp
    }
    
    /** 时间戳转日期组件 */
    public static func dateFromTimestamp(timestamp: String) -> DateComponents {
        
        let date = Date.init(timeIntervalSince1970: TimeInterval(timestamp)!)
        return date.convertedDateComponents()
    }
    
    
    
    
    
    
    
    
    
    
    
    
}






