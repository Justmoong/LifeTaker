//
//  InputView.swift
//  Chrono
//
//  Created by ymy on 1/27/25.
//

import SwiftUI

struct InputView: View {
    
    @EnvironmentObject var userData: UserData
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var lifeRemainingWorkingTime: LifeRemainingWorkingTime

    init(userData: UserData, userLivedTime: UserLivedTime) {
        _lifeRemainingWorkingTime = StateObject(wrappedValue: LifeRemainingWorkingTime(userLivedTime: userLivedTime))
    }

    
    @EnvironmentObject var monthCount: MonthCount
    @EnvironmentObject var weekCount: WeekCount
    @EnvironmentObject var dayCount: DayCount
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $userData.name)
                    
                    DatePicker("Birthday", selection: $userData.birthday, displayedComponents: .date)
                    DatePicker("End Date", selection: $userData.deathDate, displayedComponents: .date)
                }
            }
            .navigationTitle("About You")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Done") {
                        monthCount.calculateMonths(from: userData)
                        weekCount.calculateWeeks(from: userData)
                        dayCount.calculateDays(from: userData)
                        lifeRemainingWorkingTime.updateRemainingWorkingTime()
                        userData.saveToUserDefaults()
                        dismiss()
                    }
                }
            }
        }
    }
}
    
#Preview {
    InputView(userData: UserData(), userLivedTime: UserLivedTime(model: UserData()))
        .environmentObject(UserData())
        .environmentObject(MonthCount(viewModel: UserData()))
        .environmentObject(WeekCount(viewModel: UserData()))
        .environmentObject(DayCount(viewModel: UserData()))
}
