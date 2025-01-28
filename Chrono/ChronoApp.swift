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
        
    var body: some Scene {
            WindowGroup {
                HomeView()
                    .environmentObject(userData)
                    .environmentObject(MonthCount(userData: userData))
                    .environmentObject(WeekCount(userData: userData))
                    .environmentObject(DayCount(userData: userData))
        }
    }
}



