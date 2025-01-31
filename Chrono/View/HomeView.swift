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
            }
            .sheet(isPresented: $isPresented) {
                InputView()
                    .interactiveDismissDisabled(true)
            }
            .onTapGesture {
                isPresented = true
            }
            Section {
                EventPlainView(title: "Months")
                    .environmentObject(monthCount)
                EventPlainView(title: "Weeks")
                    .environmentObject(weekCount)
                EventPlainView(title: "Days")
                    .environmentObject(dayCount)
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
        .environmentObject(MonthCount(viewModel: UserData()))
        .environmentObject(WeekCount(viewModel: UserData()))
        .environmentObject(DayCount(viewModel: UserData()))
}
