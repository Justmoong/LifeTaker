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
    
    private let calendar = Calendar.current
    private var cancellables = Set<AnyCancellable>()
    @ObservedObject var userData: UserData
    
    init(userData: UserData) {
        self.userData = userData
        calculateMonths()
        
        Publishers.Merge3(
            userData.$birthday.map { _ in },
            userData.$deathDate.map { _ in },
            userData.$sex.map { _ in }
        )
        .sink { [weak self] in
            self?.calculateMonths()
        }
        .store(in: &cancellables)
    }
    
    func calculateMonths() {
        let now = Date()
        
        let passedComponents = calendar.dateComponents([.year, .month], from: userData.birthday, to: now)
        let passedYears = passedComponents.year ?? 0
        let passedMonths = passedComponents.month ?? 0
        self.passedMonths = passedYears * 12 + passedMonths
        
        let leftComponents = calendar.dateComponents([.year, .month], from: now, to: userData.deathDate)
        let leftYears = leftComponents.year ?? 0
        let leftMonths = leftComponents.month ?? 0
        self.leftMonths = max(leftYears * 12 + leftMonths, 0)
        
        let totalComponents = calendar.dateComponents([.year, .month], from: userData.birthday, to: userData.deathDate)
        let totalYears = totalComponents.year ?? 0
        let totalMonths = totalComponents.month ?? 0
        self.totalMonths = totalYears * 12 + totalMonths
    }
}
