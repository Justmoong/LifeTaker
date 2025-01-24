//
//  InputUserInfoView.swift
//  Chrono
//
//  Created by 윤무영 on 10/14/24.
//

import SwiftUI

struct InputUserInfoView: View {
    @StateObject var userData: UserData
    @ObservedObject var monthCount: MonthCount
    @ObservedObject var weekCount: WeekCount
    @ObservedObject var dayCount: DayCount
    @Environment(\.dismiss) private var dismiss
    @AppStorage("isCalcAuto") private var isCalcAuto: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        TextField("Enter Name", text: $userData.name)
                            .textFieldStyle(.roundedBorder)
                            .foregroundStyle(
                                userData.name.isEmpty ? .secondary : .primary
                            )
                    }
                    Toggle("Auto Calculate", isOn: $isCalcAuto)
                        .tint(.accentColor)
                    DatePicker("Birthday :", selection: $userData.birthday, displayedComponents: .date)
                }
                if isCalcAuto {
                    HStack {
                        Picker("Select Sex", selection: $userData.sex) {
                            Text("Male").tag("Male")
                            Text("Female").tag("Female")
                        }
                        .pickerStyle(.segmented)
                        .labelsHidden()
                    }
                } else {
                    DatePicker("Last day :", selection: $userData.deathDate, displayedComponents: .date)
                }
                Spacer()
            }
            .navigationTitle("About You")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Done") {
                        userData.setAge()
                        if isCalcAuto {
                            userData.setDeathDate()
                        }
                        monthCount.calculateMonths()
                        weekCount.calculateWeeks()
                        dayCount.calculateDays()
                        dismiss()
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    InputUserInfoView(userData: UserData(), monthCount: MonthCount(userData: UserData()), weekCount: WeekCount(userData: UserData()), dayCount: DayCount(userData: UserData()))
}
