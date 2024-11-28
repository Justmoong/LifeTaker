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
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
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

        // 생일이 지났는지 여부 확인
        let birthComponents = calendar.dateComponents([.year, .month, .day], from: birthday)
        let nowComponents = calendar.dateComponents([.year, .month, .day], from: now)

        var age = (nowComponents.year ?? 0) - (birthComponents.year ?? 0)

        // 현재 날짜가 생일 전이라면 나이에서 1을 뺌
        if let nowMonth = nowComponents.month, let nowDay = nowComponents.day,
           let birthMonth = birthComponents.month, let birthDay = birthComponents.day {
            if nowMonth < birthMonth || (nowMonth == birthMonth && nowDay < birthDay) {
                age -= 1
            }
        }

        // 유효 범위 내로 값 제한
        userAge = max(0, Float(age))
    }
}

#Preview{
    InputUserInfoView(inputedName: .constant(""), userBirthday: .constant(Date()), userAge: .constant(24), userSex: .constant(""))
}
