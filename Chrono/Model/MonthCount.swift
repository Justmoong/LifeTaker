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
        
        // UserData 변경 사항 감지
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
        
        // 생일부터 현재까지 지난 개월 수 계산
        let passedComponents = calendar.dateComponents([.year, .month], from: userData.birthday, to: now)
        let passedYears = passedComponents.year ?? 0
        let passedMonths = passedComponents.month ?? 0
        self.passedMonths = passedYears * 12 + passedMonths
        
        // 현재부터 사망일까지 남은 개월 수 계산
        let leftComponents = calendar.dateComponents([.year, .month], from: now, to: userData.deathDate)
        let leftYears = leftComponents.year ?? 0
        let leftMonths = leftComponents.month ?? 0
        self.leftMonths = max(leftYears * 12 + leftMonths, 0)
        
        // 생애 동안의 총 개월 수 계산
        let totalComponents = calendar.dateComponents([.year, .month], from: userData.birthday, to: userData.deathDate)
        let totalYears = totalComponents.year ?? 0
        let totalMonths = totalComponents.month ?? 0
        self.totalMonths = totalYears * 12 + totalMonths
    }
}
