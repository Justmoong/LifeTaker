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
    
    let updateMonday = MondayProperties()
    let updateChristmas = ChrisrtmasProperties()
    let updateEventsArray = EventsArray()
    
    @Binding public var inputedName: String
    @Binding public var inputedBirthday: Date
    @Binding public var inputedAge: Int
    @Binding public var inputedSex: String
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    userInfo.userName = inputedName
                    userInfo.userBirthday = inputedBirthday
                    userInfo.userSex = inputedSex
                    userInfo.userAge = inputedAge
                    updateMonday.update()
                    updateChristmas.update()
                    updateEventsArray.monday()
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
                DatePicker("Your Birthday :", selection: $inputedBirthday, displayedComponents: .date)
                HStack {
                    Picker("Select Sex", selection: $inputedSex) {
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


