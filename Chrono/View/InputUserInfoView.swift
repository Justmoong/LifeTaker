//
//  InputUserInfoView.swift
//  Chrono
//
//  Created by 윤무영 on 10/14/24.
//

import SwiftUI

struct InputUserInfoView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding public var inputedName: String
    @Binding public var userBirthday: Date
    @Binding public var userAge: Float
    @Binding public var userSex: String

    var body: some View {
        VStack (spacing: 64) {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Text("Done")
                }
                .padding()
            }

            VStack {
                HStack {
                    TextField("Enter Name", text: $inputedName)
                        .textFieldStyle(.roundedBorder)
                        .foregroundStyle(
                            inputedName.isEmpty ? .secondary : .primary
                        )
                }
                DatePicker("Your Birthday :", selection: $userBirthday, displayedComponents: .date)
                    .onChange(of: userBirthday) {
                        updateAge(birthday: userBirthday)
                    }
                HStack {
                    Picker("Select Sex", selection: $userSex) {
                        Text("Male").tag("male")
                        Text("Female").tag("female")
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                }
            }.padding()
            Spacer()
        }
    }

    private func updateAge(birthday: Date) {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        userAge = Float(ageComponents.year ?? 0)
    }
}

#Preview{
    InputUserInfoView(inputedName: .constant(""), userBirthday: .constant(Date()), userAge: .constant(24), userSex: .constant(""))
}
