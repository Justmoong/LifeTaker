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
    @Published var name: String = "Remaining Mondays:"
    @Published var count: Int = 0
    @Published var gaugeValue: Int = 0
    @Published var gaugeMin: Int = 0
    @Published var gaugeMax: Int = 0
    
    private var cancellables = Set<AnyCancellable>()
    @ObservedObject var userData: UserData

    init(userData: UserData) {
        self.userData = userData
        self.update()
        bindToUserData()
    }

    private func bindToUserData() {
        userData.objectWillChange
            .sink { [weak self] _ in
                self?.update()
            }
            .store(in: &cancellables)
    }

    private func calculateMondays(from startDate: Date, to endDate: Date) -> Int {
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

    func totalMondaysInLifetime() -> Int {
        return calculateMondays(from: userData.birthday, to: userData.deathDate)
    }

    func passedMondaysInLifetime() -> Int {
        return calculateMondays(from: userData.birthday, to: now)
    }

    func remainingMondaysInLifetime() -> Int {
        return calculateMondays(from: now, to: userData.deathDate)
    }

    func update() {
        let totalMondays = self.totalMondaysInLifetime()
        let passedMondays = self.passedMondaysInLifetime()
        let remainingMondays = self.remainingMondaysInLifetime()

        self.count = remainingMondays
        self.gaugeMax = totalMondays
        self.gaugeValue = passedMondays
    }
}
