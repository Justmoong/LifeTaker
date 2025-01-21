//
//  InputUserInfoView.swift
//  Chrono
//
//  Created by 윤무영 on 10/14/24.
//

import SwiftUI

struct InputUserInfoView: View {
    @ObservedObject var userData: UserData
    @ObservedObject var monthCount: MonthCount
    @ObservedObject var weekCount: WeekCount
    @ObservedObject var dayCount: DayCount
    @Environment(\.dismiss) private var dismiss
    @State var isCalcAuto: Bool = true

    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Spacer()
                Button(action: {
                    userData.setAge()
                    userData.setDeathDate()
                    monthCount.calculateMonths()
                    weekCount.calculateWeeks()
                    dayCount.calculateDays()
                    dismiss()
                }) {
                    Text("Done")
                        .fontWeight(.semibold)
                }
                .padding()
            }
            Section(header: Text("User Info")
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .padding(.leading, 16)
            )
            {
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
                    DatePicker("Your Birthday :", selection: $userData.birthday, displayedComponents: .date)
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
                    DatePicker("Your Deathday :", selection: $userData.deathDate, displayedComponents: .date)
                }
            }
        }
        .padding()
        Spacer()
    }
}

#Preview {
    InputUserInfoView(userData: UserData(), monthCount: MonthCount(userData: UserData()), weekCount: WeekCount(userData: UserData()), dayCount: DayCount(userData: UserData()))
}
