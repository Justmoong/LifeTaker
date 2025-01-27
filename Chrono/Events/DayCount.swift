//
//  DayCount.swift
//  Chrono
//
//  Created by ymy on 1/21/25.
//

import Foundation
import SwiftUI

class DayCount: ObservableObject {
    
    @Published var passedDays: Int = 0
    @Published var leftDays: Int = 0
    @Published var totalDays: Int = 0
    
    @EnvironmentObject var userData: UserData
    
    func calculateDays() {
        
        let passedDays = calendar.dateComponents([.day], from: userData.birthday, to: now).day ?? 0
        self.passedDays = passedDays
        
        let remainingDays = calendar.dateComponents([.day], from: now, to: userData.deathDate).day ?? 0
        self.leftDays = max(remainingDays, 0)
        
        let totalDays = calendar.dateComponents([.day], from: userData.birthday, to: userData.deathDate).day ?? 0
        self.totalDays = totalDays
    }
}
