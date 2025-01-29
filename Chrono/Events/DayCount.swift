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
    @Published var leftDays: Int = 0 {
        didSet {
            print("Remaining days: \(leftDays)")
        }
    }
    
    @ObservedObject var userData: UserData
    
    init(viewModel: UserData) {
        self.userData = viewModel
        calculateDays()
    }

    func calculateDays() {
        
        let remainingDays = calendar.dateComponents([.day], from: now, to: userData.deathDate).day ?? 0
        leftDays = max(remainingDays, 0)
        print("Remaining days: \(self.leftDays)")
    }
}
