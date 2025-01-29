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
    @Published var leftWeeks: Int = 0 {
        didSet {
            print("Remaining weeks: \(leftWeeks)")
        }
    }
    
    @ObservedObject var userData: UserData
    
    init(viewModel: UserData) {
        self.userData = viewModel
        calculateWeeks()
    }
        
        func calculateWeeks() {

            let remainingDays = calendar.dateComponents([.day], from: now, to: userData.deathDate).day ?? 0
            leftWeeks = max(remainingDays / 7, 0)
            print("Remaining weeks: \(self.leftWeeks)")
    }
}
