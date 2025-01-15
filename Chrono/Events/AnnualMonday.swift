//
//  Monday.swift
//  Chrono
//
//  Created by 윤무영 on 12/13/24.
//

import Foundation
import SwiftUI

class AnnualMondayProperties: ObservableObject {
    @Published var count: Int = 0
    @Published var gaugeValue: Int = 0
    @Published var gaugeMax: Int = 0

    private let calendar: Calendar

    init(calendar: Calendar = Calendar.current) {
        self.calendar = calendar
    }

    static func remainingMondaysInYear() -> Int {
        let now = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: now)
        guard let startOfYear = calendar.date(from: DateComponents(year: currentYear, month: 1, day: 1)),
              let endOfYear = calendar.date(from: DateComponents(year: currentYear, month: 12, day: 31)) else {
            print("[remainingMondaysInYear] Failed to calculate start or end of year.")
            return 0
        }
        let mondaysPassed = AnnualMondayProperties().calculateMondays(from: startOfYear, to: now)
        let totalMondays = AnnualMondayProperties().calculateMondays(from: startOfYear, to: endOfYear)
        return totalMondays - mondaysPassed
    }

    static func totalMondaysInYear() -> Int {
        let now = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: now)
        guard let startOfYear = calendar.date(from: DateComponents(year: currentYear, month: 1, day: 1)),
              let endOfYear = calendar.date(from: DateComponents(year: currentYear, month: 12, day: 31)) else {
            print("[totalMondaysInYear] Failed to calculate start or end of year.")
            return 0
        }
        return AnnualMondayProperties().calculateMondays(from: startOfYear, to: endOfYear)
    }

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

    func update() {
        count = AnnualMondayProperties.remainingMondaysInYear()
        gaugeValue = AnnualMondayProperties.totalMondaysInYear() - AnnualMondayProperties.remainingMondaysInYear()
        gaugeMax = AnnualMondayProperties.totalMondaysInYear()
    }
}
