//
//  DayCount.swift
//  Chrono
//
//  Created by ymy on 1/21/25.
//

import Foundation
import SwiftUI
import Combine

class DayCount: ObservableObject {
    
    @Published var passedDays: Int = 0
    @Published var leftDays: Int = 0
    @Published var totalDays: Int = 0
    
    private let calendar = Calendar.current
    private var cancellables = Set<AnyCancellable>()
    @ObservedObject var userData: UserData
    
    init(userData: UserData) {
        self.userData = userData
        calculateDays()
        
        Publishers.Merge3(
            userData.$birthday.map { _ in },
            userData.$deathDate.map { _ in },
            userData.$sex.map { _ in }
        )
        .sink { [weak self] in
            self?.calculateDays()
        }
        .store(in: &cancellables)
    }
    
    func calculateDays() {
        
        let passedDays = calendar.dateComponents([.day], from: userData.birthday, to: now).day ?? 0
        self.passedDays = passedDays
        
        let remainingDays = calendar.dateComponents([.day], from: now, to: userData.deathDate).day ?? 0
        self.leftDays = max(remainingDays, 0)
        
        let totalDays = calendar.dateComponents([.day], from: userData.birthday, to: userData.deathDate).day ?? 0
        self.totalDays = totalDays
    }
}
