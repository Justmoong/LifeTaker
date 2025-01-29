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

    var monthCount: MonthCount
    var weekCount: WeekCount
    var dayCount: DayCount
    
    var christmas = AnnualChristmasProperties()
    var annualMondays = AnnualMondayProperties()

    @State var isPresented: Bool = false
        
    var body: some View {
        List {
            Section(header: EmptyView()) {
                UserProfileView()
            }
            .sheet(isPresented: $isPresented) {
                InputView()
                    .interactiveDismissDisabled(true)
            }
            .onTapGesture {
                isPresented = true
            }
            Section {
                EventPlainView(title: "Months", count: monthCount.leftMonths)
//                EventPlainView(title: "Weeks", count: weekCount.leftWeeks)
//                EventPlainView(title: "Days", count: dayCount.leftDays)
            }
            Section(header: Text("Annual Events")) {
                EventGaugeView(title: christmas.name, count: christmas.count, gaugeValue: christmas.gaugeValue, min: 0, max: lengthOfYear)
                EventGaugeView(title: annualMondays.name, count: annualMondays.count, gaugeValue: annualMondays.gaugeValue, min: 0, max: annualMondays.gaugeMax)
                
            }
        }
    }
}

#Preview {
    HomeView(monthCount: MonthCount(viewModel: UserData()), weekCount: WeekCount(viewModel: UserData()), dayCount: DayCount(viewModel: UserData()))
        .environmentObject(UserData())
        .environmentObject(MonthCount(viewModel: UserData()))
        .environmentObject(WeekCount(viewModel: UserData()))
        .environmentObject(DayCount(viewModel: UserData()))
}
