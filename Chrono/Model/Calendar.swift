//
//  Calendar.swift
//  Chrono
//
//  Created by 윤무영 on 12/13/24.
//
import Foundation

class ChronoCalendar {
    
    var calendar: Calendar
    var now: Date

    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    init() {
        calendar = Calendar.current
        now = Date()
    }
    
    // 연도의 길이 계산
    func lengthOfYear() -> Int {
        let currentYear = calendar.component(.year, from: now)
        if (currentYear % 4 == 0 && currentYear % 100 != 0) || currentYear % 400 == 0 {
            return 366
        } else {
            return 365
        }
    }
    // 특정 날짜에 연도 추가
    func addYears(to date: Date, years: Int) -> Date? {
        return calendar.date(byAdding: .year, value: years, to: date)
    }
}
