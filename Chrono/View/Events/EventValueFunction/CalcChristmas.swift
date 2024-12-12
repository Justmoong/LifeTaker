//
//  CalcChristmas.swift
//  Chrono
//
//  Created by 윤무영 on 11/29/24.
//

import Foundation
//디데이
public func remainingChristmasDays() -> Int {

    let calendar = Calendar.current
    let now = Date()
    let currentYear = calendar.component(.year, from: now)

    guard let christmasDate = calendar.date(from: DateComponents(year: currentYear, month: 12, day: 25)) else {
        print("[remainingChristmasDays] Failed to calculate Christmas date.")
        return 0
    }

    if now > christmasDate {
        guard let nextChristmasDate = calendar.date(from: DateComponents(year: currentYear + 1, month: 12, day: 25)) else {
            print("[remainingChristmasDays] Failed to calculate next year's Christmas date.")
            return 0
        }
        let days = calendar.dateComponents([.day], from: now, to: nextChristmasDate).day ?? 0
        print("[remainingChristmasDays] Days until next Christmas: \(days)")
        return days
    }

    let days = calendar.dateComponents([.day], from: now, to: christmasDate).day ?? 0
    print("[remainingChristmasDays] Days until Christmas: \(days)")
    return days
}
//게이지의 값
public func daysPassedInYear() -> Int {

    let calendar = Calendar.current
    let now = Date()

    guard let startOfYear = calendar.date(from: DateComponents(year: calendar.component(.year, from: now), month: 1, day: 1)) else {
        print("Failed to calculate start of year date.")
        return 0
    }
    print("[daysPassedInYear] Passed days in this year calculated: \(calendar.dateComponents([.day], from: startOfYear, to: now).day ?? 0)")
    return calendar.dateComponents([.day], from: startOfYear, to: now).day ?? 0
}


struct ChristmasEventProperties {
    private var name: String = "Christmas"
    private var DDay: Int
    private var gaugeValue: Int
    private var min: Int = 0
    private var max: Int = 365
}

func createChristmasEvent() -> EventsProperties {
    let DDay = remainingChristmasDays()
    let gaugeValue = daysPassedInYear()
    return EventsProperties(name: "Christmas", DDay: DDay, gaugeValue: gaugeValue, min: 0, max: 365)
}
