//
//  ContentView.swift
//  Regret Vaccine
//
//  Created by 윤무영 on 9/26/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @StateObject private var userData = UserDataManager()
    @StateObject private var eventData = EventDataManager()
    //edit UserPrifle mode on sheet
    @State var isPresented: Bool = false
    //Events model
    @State private var event: [Event] = [
        Event(
            name: "Real Christmas",
            DDay: remainingChristmasDays() + 1,
            gaugeValue: daysPassedInYear(),
            min: 1,
            max: 365 //따지고 보면 윤년이 있으니 365로 하드코딩 하면 안 된다.
        )
    ]
    
    var body: some View {
        List {
            Section(header: EmptyView()) {
                UserProfileView(
                    showingName: $userData.userData.userName,
                    userAge: $userData.userData.userAge,
                    userBirthDay: $userData.userData.userBirthDay,
                    userExpectedLifespan: $userData.userData.expectedLifespan
                )
                .sheet(isPresented: $isPresented) {
                    InputUserInfoView(
                        inputedName: $userData.userData.userName,
                        userBirthday: $userData.userData.userBirthDay,
                        userAge: $userData.userData.userAge,
                        userSex: $userData.userData.userSex,
                        expectedLifespan: $userData.userData.expectedLifespan
                    )
                }
                .onTapGesture {
                    isPresented.toggle()
                }
            }
            Section(header: Text("Annual Events")) {
                EventsListView(event: $event)
                    .onAppear() //뷰가 표시될 때 변수들을 print로 출력
                {
                    print("EventsArray.0.name set: \(event[0].name)")
                    print("EventsArray.0.DDay set: \(event[0].DDay)")
                    print("EventsArray.0.gaugeValue set: \(event[0].gaugeValue)")
                    print("EventsArray.0.min set: \(event[0].min)")
                    print("EventsArray.0.max set: \(event[0].max)\n")

                }
            }
        }
    }
    

}
    



#Preview {
    HomeView()
}

// EventsArray.0.name:
