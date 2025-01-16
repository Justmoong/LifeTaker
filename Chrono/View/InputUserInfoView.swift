//
//  InputUserInfoView.swift
//  Chrono
//
//  Created by 윤무영 on 10/14/24.
//

import SwiftUI

struct InputUserInfoView: View {
    @ObservedObject var userData: UserData
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    userData.setAge()
                    userData.setDeathDate()
                    dismiss()
                }) {
                    Text("Done")
                        .fontWeight(.semibold)
                }
                .padding()
            }
            VStack {
                HStack {
                    TextField("Enter Name", text: $userData.name)
                        .textFieldStyle(.roundedBorder)
                        .foregroundStyle(
                            userData.name.isEmpty ? .secondary : .primary
                        )
                }
                DatePicker("Your Birthday :", selection: $userData.birthday, displayedComponents: .date)
                HStack {
                    Picker("Select Sex", selection: $userData.sex) {
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                }
            }
            .padding()
            Spacer()
        }
    }
}


