//
//  InputUserInfoView.swift
//  Chrono
//
//  Created by 윤무영 on 10/14/24.
//

import SwiftUI

struct InputUserInfoView: View {

    @Environment(\.dismiss) private var dismiss
    
//    @Binding public var userName: String

    @State public var inputedName: String = ""
    @State public var userBirthday: Date = .now
    @State public var userSex: String = "male"

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
      }

    VStack {
      HStack {
          TextField("Enter Name", text: $inputedName)
          .textFieldStyle(.roundedBorder)
          .foregroundStyle(
            inputedName.isEmpty ? .secondary : .primary
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
    InputUserInfoView()
}
