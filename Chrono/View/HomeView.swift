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
    
    var christmas = AnnualChristmasProperties()
    var annualMondays = AnnualMondayProperties()

    @EnvironmentObject private var monthCount: MonthCount
    @EnvironmentObject private var weekCount: WeekCount
    @EnvironmentObject private var dayCount: DayCount
    
//    init(userData: UserData) {
//        _monthCount = StateObject(wrappedValue: MonthCount(userData: userData))
//        _weekCount = StateObject(wrappedValue: WeekCount(userData: userData))
//        _dayCount = StateObject(wrappedValue: DayCount(userData: userData))
//    }
    
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
            EventPlainView(title: "Months", count: $monthCount.leftMonths)
            EventPlainView(title: "Weeks", count: $weekCount.leftWeeks)
            EventPlainView(title: "Days", count: $dayCount.leftDays)
        }
            
            Section(header: Text("Annual Events")) {
                EventGaugeView(title: christmas.name, count: christmas.count, gaugeValue: christmas.gaugeValue, min: 0, max: lengthOfYear)
                EventGaugeView(title: annualMondays.name, count: annualMondays.count, gaugeValue: annualMondays.gaugeValue, min: 0, max: annualMondays.gaugeMax)
                
            }
        }

            
    }
}

#Preview {
    HomeView()
        .environmentObject(UserData())
        .environmentObject(MonthCount(userData: UserData()))
        .environmentObject(WeekCount(userData: UserData()))
        .environmentObject(DayCount(userData: UserData()))
}
