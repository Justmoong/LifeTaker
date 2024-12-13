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
    @StateObject var eventList = EventsArray(events: [])
    
    
    @State var isPresented: Bool = false
    
    var body: some View {
        List {
            Section(header: EmptyView()) {
                UserProfileView(userData: userDataModel)
                    .sheet(isPresented: $isPresented) {
                        InputUserInfoView(
                            userInfo: userDataModel,
                            inputedName: $userDataModel.userName,
                            userBirthday: $userDataModel.userBirthday,
                            userAge: $userDataModel.userAge,
                            userSex: $userDataModel.userSex,
                            expectedLifespan: $userDataModel.userExpectedLifespan
                        )
                    }
                    .onTapGesture {
                        isPresented.toggle()
                        print(#function, "isPresented: \(isPresented)")
                    }
            }
            Section(header: Text("Annual Events")) {
                EncodedEventsListView(eventList:eventList)
            }
        }
    }
}

#Preview {
    HomeView()
}
