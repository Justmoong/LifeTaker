//: [Previous](@previous)

import Foundation
import SwiftUI
import PlaygroundSupport

// MARK: - Christmas

class ChristmasProperties {
    var passedDays: Int
    var untilDays: Int
    let daysInThisYear: () -> Int = {
        let calendar = Calendar.current
        let now = Date()
        return calendar.range(of: .day, in: .year, for: now)?.count ?? 0
    }
    
    init(passedDays: Int, untilDays: Int) {
        self.passedDays = passedDays
        self.untilDays = untilDays
    }
    
    static func daysUntilChristmas() -> Int {
        let calendar = Calendar.current
        let now = Date()
        let currentYear = calendar.component(.year, from: now)
        
        guard let christmasDate = calendar.date(from: DateComponents(year: currentYear, month: 12, day: 25)) else {
            print("[daysUntilChristmas] Failed to calculate Christmas date.")
            return 0
        }
        
        if now > christmasDate {
            guard let nextChristmas = calendar.date(from: DateComponents(year: currentYear + 1, month: 12, day: 25)) else {
                return 0
            }
            return calendar.dateComponents([.day], from: now, to: nextChristmas).day ?? 0
        } else {
            // 아직 올해의 크리스마스가 지나지 않았다면 올해 크리스마스까지의 일수를 계산
            return calendar.dateComponents([.day], from: now, to: christmasDate).day ?? 0
        }
    }
    
    static func clacPassedDays() -> Int {
        let calendar = Calendar.current
        let now = Date()
        let currentYear = calendar.component(.year, from: now)
        
        guard let startOfYear = calendar.date(from: DateComponents(year: currentYear, month: 1, day: 1)) else {
            print("[calcPassedDays] Failed to calculate the start of the year.")
            return 0
        }
        
        // 윤년 여부는 Calendar가 자동 반영
        return calendar.dateComponents([.day], from: startOfYear, to: now).day ?? 0
    }
    
    func update() {
        untilDays = Self.daysUntilChristmas()
    }
}

//class ChristmasUpdater {
//    var christmasProperties: ChristmasProperties
//    
//    func update() {
//        christmasProperties.untilDays = christmasProperties.daysUntilChristmas()
//        christmasProperties.passedDays = christmasProperties.daysInThisYear - christmasProperties.untilDays
//    }
//}
