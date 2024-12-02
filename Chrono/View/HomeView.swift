//
//  ContentView.swift
//  Regret Vaccine
//
//  Created by 윤무영 on 9/26/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @AppStorage("userName", store: UserDefaults(suiteName: "group.com.moonglab.chrono")) public var userName: String = ""
    @AppStorage("userAge", store: UserDefaults(suiteName: "group.com.moonglab.chrono")) var userAge: Int = 0
    @AppStorage("userBirthDay", store: UserDefaults(suiteName: "group.com.moonglab.chrono")) var userBirthDay: Date = Date()
    @AppStorage("expectedLifespan", store: UserDefaults(suiteName: "group.com.moonglab.chrono")) var expectedLifespan: Int = 100
    @AppStorage("userSex", store: UserDefaults(suiteName: "group.com.moonglab.chrono")) var userSex: String = "Male"
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
                EventsListView(event: $event)
                    .onAppear() //뷰가 표시될 때 변수들을 print로 출력
                {
                    
                    
                    print("EventsArray.0.name set: \(event[0].name)")
                    print("EventsArray.0.DDay set: \(event[0].DDay)")
                    print("EventsArray.0.gaugeValue set: \(event[0].gaugeValue)")
                    print("EventsArray.0.min set: \(event[0].min)")
                    print("EventsArray.0.max set: \(event[0].max)\n")
                    
//                    print("EventsArray.1.name set: \(event[1].name)")
//                    print("EventsArray.1.DDay set: \(event[1].DDay)")
//                    print("EventsArray.1.gaugeValue set: \(event[1].gaugeValue)")
//                    print("EventsArray.1.min set: \(event[1].min)")
//                    print("EventsArray.1.max set: \(event[1].max)\n")
                }
            }
        }
    }
    

}
    



#Preview {
    HomeView()
}

// EventsArray.0.name:
