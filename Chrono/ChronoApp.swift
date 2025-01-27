//
//  Regret_VaccineApp.swift
//  Regret Vaccine
//
//  Created by 윤무영 on 9/26/24.
//

import SwiftUI
import SwiftData

@main
struct ChronoApp: App {
    @StateObject var userData = UserData()
    @StateObject private var monthCount = MonthCount(userData: UserData())
    @StateObject private var weekCount = WeekCount(userData: UserData())
    @StateObject private var dayCount = DayCount(userData: UserData())
        
    var body: some Scene {
            WindowGroup {
                HomeView(userData: userData)
                    .environmentObject(userData)
                    .environmentObject(monthCount)
                    .environmentObject(weekCount)
                    .environmentObject(dayCount)
        }
    }
}



