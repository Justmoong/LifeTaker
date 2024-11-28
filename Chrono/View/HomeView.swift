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
    
    var userExpectedLifespan: Float {
            max(1, expectedLifespan) // 항상 expectedLifespan에 따라 계산, 1로 최솟값 제한.
        }
    
    var body: some View {
        List {
            Section(header: EmptyView()) {
                UserProfileView(showingName: $userName, userAge: $userAge, userBirthDay: $userBirthDay, userExpectedLifespan: $expectedLifespan)
                    .onTapGesture {
                        isPresented.toggle()
                    }
                    .sheet(isPresented: $isPresented) {
                        InputUserInfoView(
                            inputedName: $userName,
                            userBirthday: $userBirthDay, // 실제 데이터로 교체 필요
                            userAge: $userAge,
                            userSex: $userSex // 실제 데이터로 교체 필요
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

