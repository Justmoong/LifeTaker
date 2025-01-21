//
//  WeekCount.swift
//  Chrono
//
//  Created by ymy on 1/21/25.
//

import Foundation
import SwiftUI
import Combine

class WeekCount: ObservableObject {
    
    @Published var passedWeeks: Int = 0
    @Published var leftWeeks: Int = 0
    @Published var totalWeeks: Int = 0
    
    private let calendar = Calendar.current
    private var cancellables = Set<AnyCancellable>()
    @ObservedObject var userData: UserData
    
    init(userData: UserData) {
        self.userData = userData
        calculateWeeks()
        
        Publishers.Merge3(
            userData.$birthday.map { _ in },
            userData.$deathDate.map { _ in },
            userData.$sex.map { _ in }
        )
        .sink { [weak self] in
            self?.calculateWeeks()
        }
        .store(in: &cancellables)
    }
    
    func calculateWeeks() {
        let now = Date()
        
        let passedDays = calendar.dateComponents([.day], from: userData.birthday, to: now).day ?? 0
        self.passedWeeks = passedDays / 7
        
        let remainingDays = calendar.dateComponents([.day], from: now, to: userData.deathDate).day ?? 0
        self.leftWeeks = max(remainingDays / 7, 0)
        
        let totalDays = calendar.dateComponents([.day], from: userData.birthday, to: userData.deathDate).day ?? 0
        self.totalWeeks = totalDays / 7
    }
}
