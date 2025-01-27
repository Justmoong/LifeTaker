//
//  LifetimeMondayProperties.swift
//  Chrono
//
//  Created by ymy on 1/27/25.
//

import Foundation
import SwiftUI
import Combine

class LifetimeMondayProperties: ObservableObject {
    
    let userData: UserData
    @Published var passedMondays: Int = 0
    @Published var remainingMondays: Int = 0
    @Published var totalMondays: Int = 0
    
    init(userData: UserData) {
        self.userData = userData
        updateMondays()
    }
    
    func updateMondays() {
        self.totalMondays = calculateMondays(from: userData.birthday, to: userData.deathDate)
        self.passedMondays = calculateMondays(from: userData.birthday, to: Date())
        self.remainingMondays = calculateMondays(from: Date(), to: userData.deathDate)
    }
    
    private func calculateMondays(from startDate: Date, to endDate: Date) -> Int {
        var count = 0
        var date = startDate
        let calendar = Calendar.current
        while date <= endDate {
            if calendar.component(.weekday, from: date) == 2 {
                count += 1
            }
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }
        return count
    }
}
