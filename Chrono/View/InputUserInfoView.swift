//
//  InputUserInfoView.swift
//  Chrono
//
//  Created by 윤무영 on 10/14/24.
//

import SwiftUI

struct InputUserInfoView: View {
    
    @State var userBirthday: Date
    @State var userSex: String?
    
    var body: some View {
        VStack {
            DatePicker("Birthday", selection: $userBirthday, displayedComponents: .date)
            HStack {
                Picker("Select Sex", selection: $userSex) {
                    Text("Male").tag("male")
                    Text("Female").tag("female")
                }
                .pickerStyle(.segmented)
                .labelsHidden()
            }
        }
//        .padding()
    }
}


#Preview {
    InputUserInfoView(userBirthday: Date(), userSex: "male")
}
