//
//  AnnualEvent.swift
//  Chrono
//
//  Created by 윤무영 on 11/29/24.
//
import Foundation
import SwiftUI
import Combine

class MonthCount: ObservableObject {
    @Published var passedMonths: Int = 0
    @Published var leftMonths: Int = 0
    @Published var totalMonths: Int = 0

    private var userData: UserData
    private var cancellables: Set<AnyCancellable> = []

    init(userData: UserData) {
        self.userData = userData
        setupBindings()
        calculateMonths()
    }

    private func setupBindings() {
        userData.$birthday
                   .sink { [weak self] _ in
                       self?.calculateMonths()
                   }
                   .store(in: &cancellables)

               userData.$deathDate
                   .sink { [weak self] _ in
                       self?.calculateMonths()
                   }
                   .store(in: &cancellables)
    }

    func calculateMonths() {
        let passedComponents = calendar.dateComponents([.year, .month], from: userData.birthday, to: now)
        self.passedMonths = (passedComponents.year ?? 0) * 12 + (passedComponents.month ?? 0)

        let leftComponents = calendar.dateComponents([.year, .month], from: now, to: userData.deathDate)
        self.leftMonths = max((leftComponents.year ?? 0) * 12 + (leftComponents.month ?? 0), 0)

        let totalComponents = calendar.dateComponents([.year, .month], from: userData.birthday, to: userData.deathDate)
        self.totalMonths = (totalComponents.year ?? 0) * 12 + (totalComponents.month ?? 0)
    }
}
