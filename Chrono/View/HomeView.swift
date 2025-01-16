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
    
    @State var isPresented: Bool = false
    
    var body: some View {
        List {
            Section(header: EmptyView()) {
                UserProfileView(userData: userData)
                    .sheet(isPresented: $isPresented) {
                        InputUserInfoView(userData: userData)
                    }
                    .onTapGesture {
                        isPresented = true
                        christmas.update()
                        print(#function, "isPresented: \(isPresented)")
                        
                    }
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
