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
    
    private var userData: UserData
    private var cancellables: Set<AnyCancellable> = []
    
    init(userData: UserData) {
        self.userData = userData
        setupBindings()
        calculateDays()
    }
    
    private func setupBindings() {
        userData.$birthday
                   .sink { [weak self] _ in
                       self?.calculateDays()
                   }
                   .store(in: &cancellables)

               userData.$deathDate
                   .sink { [weak self] _ in
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
