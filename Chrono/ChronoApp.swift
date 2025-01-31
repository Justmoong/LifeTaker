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
    @StateObject var monthCount: MonthCount
    @StateObject var weekCount: WeekCount
    @StateObject var dayCount: DayCount

    init() {
        let sharedUserData = UserData()
        _userData = StateObject(wrappedValue: sharedUserData) // StateObject를 init에서 초기화
        _monthCount = StateObject(wrappedValue: MonthCount(viewModel: sharedUserData))
        _weekCount = StateObject(wrappedValue: WeekCount(viewModel: sharedUserData))
        _dayCount = StateObject(wrappedValue: DayCount(viewModel: sharedUserData))
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(userData)
                .environmentObject(monthCount)
                .environmentObject(weekCount)
                .environmentObject(dayCount)
        }
    }
}

