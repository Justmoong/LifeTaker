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
    private var cancellables: Set<AnyCancellable> = []
    
    init(viewModel: UserData) {
        self.userData = viewModel
        calculateDays(from: viewModel)
        
        userData.$deathDate
            .sink { [weak self] _ in
                self?.calculateDays(from: viewModel)
            }
            .store(in: &cancellables)
    }

    func calculateDays(from userData: UserData) {
        let deathDate = userData.deathDate
        
        let remainingDays = calendar.dateComponents([.day], from: now, to: deathDate).day ?? 0
        leftDays = max(remainingDays, 0)
        print("Remaining days: \(self.leftDays)")
    }
}
