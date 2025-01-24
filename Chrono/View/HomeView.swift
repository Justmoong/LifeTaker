//
//  ContentView.swift
//  Regret Vaccine
//
//  Created by 윤무영 on 9/26/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @StateObject private var userData = UserData()
    
    private var christmas = AnnualChristmasProperties()
    private var annualMondays = AnnualMondayProperties()
    @StateObject private var monthCount: MonthCount
    @StateObject private var weekCount: WeekCount
    @StateObject private var dayCount: DayCount
    
    @State var isPresented: Bool = false
    
    init() {
        let userData = UserData()
        _userData = StateObject(wrappedValue: userData)
        _monthCount = StateObject(wrappedValue: MonthCount(userData: userData))
        _weekCount = StateObject(wrappedValue: WeekCount(userData: userData))
        _dayCount = StateObject(wrappedValue: DayCount(userData: userData))
    }
    
    var body: some View {
        List {
            Section(header: EmptyView()) {
                UserProfileView(userData: userData)
            }
            .sheet(isPresented: $isPresented) {
                    InputUserInfoView(userData: userData,
                                      monthCount: monthCount,
                                      weekCount: weekCount,
                                      dayCount: dayCount
                    ).interactiveDismissDisabled(true)
            }
            .onTapGesture {
                isPresented = true
            }
            Section(header: Text("In Remaining Lifetime")) {
                EventPlainView(title: "Months", count: monthCount.leftMonths, gaugeValue: monthCount.passedMonths, min: 0, max: monthCount.totalMonths)
                EventPlainView(title: "Weeks", count: weekCount.leftWeeks, gaugeValue: weekCount.passedWeeks, min: 0, max: weekCount.totalWeeks)
                EventPlainView(title: "Days", count: dayCount.leftDays, gaugeValue: dayCount.passedDays, min: 0, max: dayCount.totalDays)
            }
            Section(header: Text("Annual Events")) {
                EventGaugeView(title: christmas.name, count: christmas.count, gaugeValue: christmas.gaugeValue, min: 0, max: lengthOfYear)
                EventGaugeView(title: annualMondays.name, count: annualMondays.count, gaugeValue: annualMondays.gaugeValue, min: annualMondays.gaugeMin, max: annualMondays.gaugeMax)
            }
        }
    }
}

#Preview {
    HomeView()
}
