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
    
    private var userData: UserData
    private var cancellables: Set<AnyCancellable> = []
    
    init(userData: UserData) {
        self.userData = userData
        setupBindings()
        calculateWeeks()
    }
    
    private func setupBindings() {
        userData.$birthday
                   .sink { [weak self] _ in
                       self?.calculateWeeks()
                   }
                   .store(in: &cancellables)

               userData.$deathDate
                   .sink { [weak self] _ in
                       self?.calculateWeeks()
                   }
                   .store(in: &cancellables)
    }
        
        func calculateWeeks() {
            
            let passedDays = calendar.dateComponents([.day], from: userData.birthday, to: now).day ?? 0
            self.passedWeeks = passedDays / 7
            
            let remainingDays = calendar.dateComponents([.day], from: now, to: userData.deathDate).day ?? 0
            self.leftWeeks = max(remainingDays / 7, 0)
            
            let totalDays = calendar.dateComponents([.day], from: userData.birthday, to: userData.deathDate).day ?? 0
            self.totalWeeks = totalDays / 7
        
    }
}
