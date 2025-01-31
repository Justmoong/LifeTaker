//
//  EventCircleVIew.swift
//  Chrono
//
//  Created by ymy on 1/21/25.
//

import Foundation
import SwiftUI
import Combine

struct EventPlainView: View {
    var title: String
    @EnvironmentObject var monthCount: MonthCount
    @EnvironmentObject var weekCount: WeekCount
    @EnvironmentObject var dayCount: DayCount
    
    var body: some View {
        HStack(spacing: 16) {
            Text(title)
                .font(.callout)
            Spacer()
            Text("\(countValue())")
                .font(.headline)
                .foregroundStyle(Color.accentColor)
        }
        .onReceive(NotificationCenter.default.publisher(for: .deathDateUpdated)) { _ in
            monthCount.objectWillChange.send()
            weekCount.objectWillChange.send()
            dayCount.objectWillChange.send()
        }
    }
        
        func countValue() -> Int {
            switch title {
            case "Months":
                return monthCount.leftMonths
            case "Weeks":
                return weekCount.leftWeeks
            case "Days":
                return dayCount.leftDays
            default:
                return 0
            
        }
    }
}
