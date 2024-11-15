//
//  NextChristmasView.swift
//  Chrono
//
//  Created by 윤무영 on 11/14/24.
//
import Foundation
import SwiftUI

struct RemainingChristmasView: View {
    
    @State var remaining = remainingChristmases(currentAge: 22, expectedLifespan: 81)
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text("Remaining Christmases")
                    .font(.callout)
                Spacer()
                Text("\(remaining)")
                    .foregroundStyle(Color.accentColor)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            Gauge(value: 100, in: 1...100){
                
            }
            .gaugeStyle(.accessoryLinearCapacity)
            .foregroundStyle(Color.accentColor)
            .tint(Color.accentColor)
            .labelsHidden()
        }
        .padding(.vertical, 8)
    }
}

// MARK: Calculate Next Christmas

public func remainingChristmases(currentAge: Int, expectedLifespan: Int) -> Int {
    let calendar = Calendar.current
    let now = Date()
    let currentMonth = calendar.component(.month, from: now)
    let currentDay = calendar.component(.day, from: now)
    
    // 현재 연도에서 남은 생애 연도 계산
    let remainingYears = expectedLifespan - currentAge
    var remainingChristmases = remainingYears
    
    // 현재 날짜가 12월 25일 이후인지 확인
    if currentMonth > 12 || (currentMonth == 12 && currentDay > 25) {
        remainingChristmases -= 1
    }
    
    return remainingChristmases
}

// 사용 예시


#Preview {
    RemainingChristmasView()
}
