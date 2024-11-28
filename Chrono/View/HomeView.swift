//
//  ContentView.swift
//  Regret Vaccine
//
//  Created by 윤무영 on 9/26/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @AppStorage("userName", store: UserDefaults(suiteName: "group.com.moonglab.chrono")) var userName: String = ""
    @AppStorage("userAge", store: UserDefaults(suiteName: "group.com.moonglab.chrono")) var userAge: Int = 0
    @AppStorage("userBirthDay", store: UserDefaults(suiteName: "group.com.moonglab.chrono")) var userBirthDay: Date = Date()
    @AppStorage("expectedLifespan", store: UserDefaults(suiteName: "group.com.moonglab.chrono")) var expectedLifespan: Int = 100
    @AppStorage("userSex", store: UserDefaults(suiteName: "group.com.moonglab.chrono")) var userSex: String = "Male"
        
    @State var isPresented: Bool = false
    
    var body: some View {
        List {
            Section(header: EmptyView()) {
                UserProfileView(showingName: $userName,
                                userAge: $userAge,
                                userBirthDay: $userBirthDay,
                                userExpectedLifespan: $expectedLifespan
                )
                .sheet(isPresented: $isPresented) {
                    InputUserInfoView(
                        inputedName: $userName,
                        userBirthday: $userBirthDay,
                        userAge: $userAge,
                        userSex: $userSex,
                        expectedLifespan: $expectedLifespan)
                }
                .onTapGesture {
                    isPresented.toggle()
                }
            }
            
            
            Section(header: Text("Annual Events")) {
                RemainingChristmasView()
            }
        }
    }
}
    
#Preview {
    HomeView()
}

