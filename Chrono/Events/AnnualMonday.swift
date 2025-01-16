//
//  Monday.swift
//  Chrono
//
//  Created by 윤무영 on 12/13/24.
//

import Foundation
import SwiftUI

class AnnualMondayProperties: ObservableObject {
    let name: String = "Monday"
    @Published var count: Int = 0
    @Published var gaugeValue: Int = 0
    let gaugeMin: Int = 0
    @Published var gaugeMax: Int = 0

    init() {
        self.update()
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

        let mondaysPassed = calculateMondays(from: startOfYear, to: now)
        let totalMondays = calculateMondays(from: startOfYear, to: endOfYear)
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

        return calculateMondays(from: startOfYear, to: endOfYear)
    }

    static func calculateMondays(from startDate: Date, to endDate: Date) -> Int {
        let calendar = Calendar.current
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
        self.count = AnnualMondayProperties.remainingMondaysInYear()
        self.gaugeMax = AnnualMondayProperties.totalMondaysInYear()
        self.gaugeValue = self.gaugeMax - self.count
    }
}
