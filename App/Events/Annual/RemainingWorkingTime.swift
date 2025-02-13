//
//  RemainingWorkingTime.swift
//  Life Taker
//
//  Created by ymy on 2/13/25.
//

import Foundation

struct AnnualRemainingWorkingTime {
    var remainingWorkingDaysThisYear: Int
    var remainingWorkingHoursThisYear: Int
    
    init(remainingWorkingDaysThisYear: Int, remainingWorkingHoursThisYear: Int) {
        self.remainingWorkingDaysThisYear = remainingWorkingDaysThisYear
        self.remainingWorkingHoursThisYear = remainingWorkingHoursThisYear
    }
    
    static func calculateRemainingWorkingTime() -> AnnualRemainingWorkingTime {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let year = calendar.component(.year, from: today)

        let elapsedDays = ElapsedDateInThisYear.daysElapsedThisYear()
        let totalDaysThisYear = daysInYear(for: year)
        let remainingDays = totalDaysThisYear - elapsedDays

        let remainingWeekdays = countWeekdays(from: today, daysRemaining: remainingDays)
        let workingHoursPerDay = 8

        return AnnualRemainingWorkingTime(
            remainingWorkingDaysThisYear: remainingWeekdays,
            remainingWorkingHoursThisYear: remainingWeekdays * workingHoursPerDay
        )
    }

    private static func countWeekdays(from startDate: Date, daysRemaining: Int) -> Int {
        let calendar = Calendar.current
        var weekdaysCount = 0
        var date = startDate

        for _ in 0..<daysRemaining {
            if let nextDay = calendar.date(byAdding: .day, value: 1, to: date) {
                let weekday = calendar.component(.weekday, from: nextDay)
                if weekday != 1 && weekday != 7 { // 일요일(1)과 토요일(7) 제외
                    weekdaysCount += 1
                }
                date = nextDay
            }
        }

        return weekdaysCount
    }
}
