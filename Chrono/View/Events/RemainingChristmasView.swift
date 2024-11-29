//
//  NextChristmasView.swift
//  Chrono
//
//  Created by 윤무영 on 11/14/24.
//
import Foundation
import SwiftUI

struct RemainingChristmasView: View {
    
    //이 뷰는 user와 무관한 뷰이므로 바인딩하지 않는다.
    @State private var remainingChristmasDays: Int = daysUntilChristmas()
    @State private var daysPassedThisYear: Int = daysPassedInYear()
    
    var body: some View {
        VStack (alignment: .leading, spacing: 16) {
            
            HStack {
                Text("Next Christmas")
                    .font(.callout)
                Spacer()
                Text("\(remainingChristmasDays)")
                    .foregroundStyle(Color.accentColor)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            Gauge(value: Float(daysPassedThisYear), in: 1...365) {
                Text("Progress to Christmas")
            }
            .gaugeStyle(.accessoryLinearCapacity)
            .foregroundStyle(Color.accentColor)
            .tint(Color.accentColor)
            .labelsHidden()
        }
        .padding(.vertical, 8)
        .onAppear {
            // 매번 뷰가 나타날 때 날짜를 계산
            remainingChristmasDays = daysUntilChristmas() + 1
            //이유를 모르겠지만 계산 날짜가 하루 부족하여 1을 더하여 넘어간다.
        }
    }
}

// MARK: Calculate Next Christmas

func daysUntilChristmas() -> Int {
    let calendar = Calendar.current
    let now = Date()
    let currentYear = calendar.component(.year, from: now)

    guard let christmasDate = calendar.date(from: DateComponents(year: currentYear, month: 12, day: 25)) else {
        return 0
    }
    
    // 현재 날짜가 크리스마스 이후라면, 다음 해의 크리스마스를 계산
    if now > christmasDate {
        guard let nextChristmasDate = calendar.date(from: DateComponents(year: currentYear + 1, month: 12, day: 25)) else {
            return 0
        }
        return calendar.dateComponents([.day], from: now, to: nextChristmasDate).day ?? 0
    }
    return calendar.dateComponents([.day], from: now, to: christmasDate).day ?? 0
}

// MARK: Calculate Days Passed in the Year
func daysPassedInYear() -> Int {
    let calendar = Calendar.current
    let now = Date()
    
    // 현재 연도의 1월 1일 날짜 계산
    guard let startOfYear = calendar.date(from: DateComponents(year: calendar.component(.year, from: now), month: 1, day: 1)) else {
        return 0 // 날짜 계산 오류 시 0 반환
    }
    
    // 현재 날짜와 1월 1일 사이의 일수 계산
    return calendar.dateComponents([.day], from: startOfYear, to: now).day ?? 0
}


#Preview {
    RemainingChristmasView()
}
