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
    
    private var christmas = ChristmasProperties()
    private var annualMondays = AnnualMondayProperties()
    @StateObject private var monthCount: MonthCount
    
    @State var isPresented: Bool = false
    
    init() {
        let userData = UserData()
        _userData = StateObject(wrappedValue: userData)
        _monthCount = StateObject(wrappedValue: MonthCount(userData: userData))
    }
    
    var body: some View {
        List {
            Section(header: EmptyView()) {
                UserProfileView(userData: userData)
                    .sheet(isPresented: $isPresented) {
                        InputUserInfoView(userData: userData, monthCount: monthCount)
                    }
                    .onTapGesture {
                        isPresented = true
                    }
            }

            Section(header: Text("Remaining Lifetime")) {
                EventView(title: "Months", count: monthCount.leftMonths, gaugeValue: monthCount.passedMonths, min: 0, max: monthCount.totalMonths)
            }
            Section(header: Text("Annual Events")) {
                EventView(title: christmas.name, count: christmas.count, gaugeValue: christmas.gaugeValue, min: 0, max: lengthOfYear)
                EventView(title: annualMondays.name, count: annualMondays.count, gaugeValue: annualMondays.gaugeValue, min: annualMondays.gaugeMin, max: annualMondays.gaugeMax)
                
            }
        }
    }
}

#Preview {
    HomeView()
}
