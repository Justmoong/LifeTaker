//
//  Calendar.swift
//  Chrono
//
//  Created by 윤무영 on 12/13/24.
//
import Foundation

extension Calendar {
    
    var now: Date {
        return Date()
    }
    
    static func lengthOfYear() -> Int {
        
        let currentYear = Calendar.current.component(.year, from: Date())
        
        if (currentYear % 4 == 0 && currentYear % 10 != 0 || currentYear % 400 == 0) {
            return 366
        } else {
            return 365
        }
    }
}

class ChronoCalendar {
    let calendar: Calendar
    let now: Date
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func calculateMondays(from startDate: Date, to endDate: Date) -> Int {
        var mondaysCount = 0
        var date = startDate
        while date <= endDate {
            if calendar.component(.weekday, from: date) == 2 { // 월요일
                mondaysCount += 1
            }
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }
        return mondaysCount
    }
    
    func addYears(to date: Date, years: Int) -> Date? {
        return calendar.date(byAdding: .year, value: years, to: date)
    }
    
    init() {
        calendar = Calendar.current
        now = Date()
    }
}
