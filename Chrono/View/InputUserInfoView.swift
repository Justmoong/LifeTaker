//
//  InputUserInfoView.swift
//  Chrono
//
//  Created by 윤무영 on 10/14/24.
//

import SwiftUI

struct InputUserInfoView: View {

    @StateObject private var userProfile = UserProfile()
    @Environment(\.dismiss) private var dismiss
    @State var inputedUserName: String = ""
    @State var userBirthday: Date = .now
    @State var userSex: String = "male"

  var body: some View {
      VStack (spacing: 64) {
          HStack {
              Spacer()
              Button(action: {
                userProfile.userName = inputedUserName
                  dismiss()
              }) {
                  Text("Done")
              }
              .padding()
          }
      }

    VStack {
      HStack {
          TextField("Enter Name", text: $inputedUserName)
          .textFieldStyle(.roundedBorder)
          .foregroundStyle(
            inputedUserName.isEmpty ? .secondary : .primary
          )
          
      }
      DatePicker("Birthday", selection: $userBirthday, displayedComponents: .date)
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

#Preview{
    InputUserInfoView(userBirthday: Date(), userSex: "male")
}
