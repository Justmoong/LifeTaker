//
//  CalcRemainingMondays.swift
//  Chrono
//
//  Created by 윤무영 on 11/29/24.
//

import Foundation
import SwiftUI

    // 총 월요일의 수를 계산, max
    public func calculateTotalMondays() -> Int {
        let userBirthDay = UserDefaults.standard.object(forKey: "userBirthDay") as? Date ?? Date()
        let expectedLifespan = UserDefaults.standard.integer(forKey: "expectedLifespan")
        
        let calendar = Calendar.current
        guard let deathDate = calendar.date(byAdding: .year, value: expectedLifespan, to: userBirthDay) else {
            return 0
        }
        print("Debug info: [calculateTotalMondays].userBirthDay set:\(userBirthDay)")
        print("Debug info: [calculateTotalMondays].deathDate set:\(deathDate)")
        
        var totalMondays = 0
        var date = userBirthDay
        while date <= deathDate {
            if calendar.component(.weekday, from: date) == 2 { // 월요일
                totalMondays += 1
            }
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }
        return totalMondays
    }
    
    // 지금까지 지난 월요일의 수를 계산 gaugeValue
    public func calculatePastMondays() -> Int {
        let userBirthDay = UserDefaults.standard.object(forKey: "userBirthDay") as? Date ?? Date()
        let now = Date()
        let calendar = Calendar.current
        
        var pastMondays = 0
        var date = userBirthDay
        while date <= now {
            if calendar.component(.weekday, from: date) == 2 { // 월요일
                pastMondays += 1
            }
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }
        return pastMondays
    }
    
    // 앞으로 남은 월요일의 수를 계산 DDay
    public func calculateRemainingMondays() -> Int {
        let totalMondays = calculateTotalMondays()
        let pastMondays = calculatePastMondays()
        return totalMondays - pastMondays
    }


