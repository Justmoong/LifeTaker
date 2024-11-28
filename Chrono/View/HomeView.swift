//
//  ContentView.swift
//  Regret Vaccine
//
//  Created by 윤무영 on 9/26/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @State var userName: String = ""
    @State var userAge: Float = 0
    @State var userBirthDay: Date = Date()
    @State var expectedLifespan: Float = 100
    @State var userSex: String = "Male"
    @State var isPresented: Bool = false
    
    var body: some View {
        List {
            Section(header: EmptyView()) {
                UserProfileView(showingName: $userName,
                                userAge: $userAge,
                                userBirthDay: $userBirthDay,
                                userExpectedLifespan: $expectedLifespan
                )
                    .onTapGesture {
                        isPresented.toggle()
                    }
                    .sheet(isPresented: $isPresented) {
                        InputUserInfoView(
                            inputedName: $userName,
                            userBirthday: $userBirthDay,
                            userAge: $userAge,
                            userSex: $userSex,
                            expectedLifespan: $expectedLifespan
                        )
                    }
            }
            Section(header: Text("Events")) {
                RemainingChristmasView()
            }
        }
    }
}
    
#Preview {
    HomeView(userAge: 24, expectedLifespan: 87)
}

