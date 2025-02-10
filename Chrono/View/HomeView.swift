//
//  ContentView.swift
//  Regret Vaccine
//
//  Created by 윤무영 on 9/26/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @EnvironmentObject var userData: UserData

    @EnvironmentObject var monthCount: MonthCount
    @EnvironmentObject var weekCount: WeekCount
    @EnvironmentObject var dayCount: DayCount
    
    var christmas = AnnualChristmasProperties()
    var annualMondays = AnnualMondayProperties()

    @State var isPresented: Bool = false
        
    var body: some View {
        List {
            Section(header: EmptyView()) {
                UserProfileView()
                    .sheet(isPresented: $isPresented) {
                        InputView()
                            .interactiveDismissDisabled(true)
                    }
                    .onTapGesture {
                        isPresented = true
                    }
                EventPlainView(title: "Months", count: monthCount.leftMonths)
                EventPlainView(title: "Weeks", count: weekCount.leftWeeks)
                EventPlainView(title: "Days", count: dayCount.leftDays)
            }
            // 생일까지 남은 날짜, 다음 N0세 까지 남은 날짜
            Section(header: Text("Your Next")) {
                let today = Calendar.current.startOfDay(for: Date())
                    let nextBirthday = Calendar.current.nextDate(after: today, matching: Calendar.current.dateComponents([.month, .day], from: userData.birthday), matchingPolicy: .nextTimePreservingSmallerComponents) ?? today
                    let daysUntilNextBirthday = Calendar.current.dateComponents([.day], from: today, to: nextBirthday).day ?? 0

                    let currentAge = userData.age
                    let nextDecade = ((currentAge / 10) + 1) * 10
                    let yearsUntilNextDecade = nextDecade - currentAge

                EventGaugeView(
                    title: "Next Birthday",
                    count: daysUntilNextBirthday,
                    gaugeValue: daysUntilNextBirthday,
                    min: 0,
                    max: lengthOfYear
                )
                EventGaugeView(
                        title: "To Be \(nextDecade)",
                        count: yearsUntilNextDecade,
                        gaugeValue: yearsUntilNextDecade,
                        min: 0,
                        max: 10
                    )
            }
            Section(header: Text("Annual Events")) {
                EventGaugeView(title: christmas.name,
                               count: christmas.count,
                               gaugeValue: christmas.gaugeValue,
                               min: 0,
                               max: lengthOfYear
                )
                EventGaugeView(title: annualMondays.name,
                               count: annualMondays.count,
                               gaugeValue: annualMondays.gaugeValue,
                               min: 0,
                               max: annualMondays.gaugeMax
                )
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(UserData())
        .environmentObject(MonthCount(viewModel: UserData()))
        .environmentObject(WeekCount(viewModel: UserData()))
        .environmentObject(DayCount(viewModel: UserData()))
}
