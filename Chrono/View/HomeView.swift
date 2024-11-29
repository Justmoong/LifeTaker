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
        
    //edit UserPrifle
    @State var isPresented: Bool = false
    
    //Annual Events model
    @State private var event: [AnnualEvent] = [
        AnnualEvent(name: "New Year", dDay: 5, gaugeValue: 1, min: 1, max: 365),
        AnnualEvent(name: "Christmas", dDay: 5, gaugeValue: 1, min: 1, max: 365),
        AnnualEvent(name: "Real Christmas", dDay: remainingChristmasDays() + 1, gaugeValue: daysPassedInYear(), min: 1, max: 365)
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
                AnnualEventsListView(event: $event)
                    .onAppear() //뷰가 표시될 때 변수들을 print로 출력
                    {
                        print("1st event name: \(event[0].name)")
                        print("1st event progressValue: \(event[0].gaugeValue)")
                        print("1st event min: \(event[0].min)")
                        print("1st event max: \(event[0].max)\n")
                        print("2nd event name: \(event[1].name)")
                        print("2nd event progressValue: \(event[1].gaugeValue)")
                        print("2nd event min: \(event[1].min)")
                        print("2nd event max: \(event[1].max)\n")
                        print("3rd event name: \(event[2].name)")
                        print("3rd event progressValue: \(event[2].gaugeValue)")
                        print("3rd event min: \(event[2].min)")
                        print("3rd event max: \(event[2].max)\n")
                    }
            }
        }
    }
}
    
#Preview {
    HomeView()
}

