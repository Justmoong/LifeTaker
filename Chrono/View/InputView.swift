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
    @AppStorage("isCalcAuto") private var isCalcAuto: Bool = false
    
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
                        .tint(isCalcAuto ? .secondary : .primary)
                        .opacity(isCalcAuto ? 0.25 : 1)
                        .disabled(isCalcAuto)
                }
                Section {
                    Toggle("Auto Calculate", isOn: $isCalcAuto)
                        .tint(.accentColor)
                }
                if isCalcAuto {
                    Section {
                        Picker("Select Sex", selection: $userData.sex) {
                            Text("Male").tag("Male")
                            Text("Female").tag("Female")
                        }
                    }
                }
            }
            .navigationTitle("About You")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Done") {
                        if isCalcAuto {
                            userData.setDeathDate()
                        }
                        monthCount.calculateMonths(from: userData)
                        weekCount.calculateWeeks(from: userData)
                        dayCount.calculateDays(from: userData)
                        userData.setAge()
                        userData.saveToUserDefaults()
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    InputView()
        .environmentObject(UserData())
        .environmentObject(MonthCount(viewModel: UserData()))
        .environmentObject(WeekCount(viewModel: UserData()))
        .environmentObject(DayCount(viewModel: UserData()))
}
