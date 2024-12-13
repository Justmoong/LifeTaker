//
//  InputUserInfoView.swift
//  Chrono
//
//  Created by 윤무영 on 10/14/24.
//

import SwiftUI

struct InputUserInfoView: View {
    @StateObject var userInfo: UserData
    @Environment(\.dismiss) private var dismiss
    @Binding public var inputedName: String
    @Binding public var userBirthday: Date
    @Binding public var userAge: Int
    @Binding public var userSex: String
    @Binding public var expectedLifespan: Int
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    userInfo.userName = inputedName
                    userInfo.userBirthday = userBirthday
                    userInfo.userSex = userSex
                    userInfo.userAge = userAge
                    dismiss()
                }) {
                    Text("Done")
                        .fontWeight(.semibold)
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
                        
                        print("User birthday set to \(userBirthday)")
                        print("User age set to \(userAge)")
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
}


