//
//  ContentView.swift
//  Regret Vaccine
//
//  Created by 윤무영 on 9/26/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @StateObject private var userDataModel = UserData(userName: "", userSex: "", userAge: 0, userBirthday: Date(), userDeathAge: 80, userExpectedLifespan: 80)
    
    @State var isPresented: Bool = false
    
    var body: some View {
        List {
            Section(header: EmptyView()) {
                UserProfileView(userData: userDataModel)
                .sheet(isPresented: $isPresented) {
                    InputUserInfoView(
                        inputedName: $userDataModel.userName,
                        userBirthday: $userDataModel.userBirthday,
                        userAge: $userDataModel.userAge,
                        userSex: $userDataModel.userSex,
                        expectedLifespan: $userDataModel.userExpectedLifespan
                    )
                }
            }
            Section(header: Text("Events")) {
                EncodedEventsListView(event: [EventsProperties(name: "Event Name", DDay: 5, gaugeValue: 0, min: 0, max: 100)])
                    .onTapGesture {
                        isPresented.toggle()
                    }
            }
        }
    }
}

#Preview {
    HomeView()
}
