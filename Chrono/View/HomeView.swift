//
//  ContentView.swift
//  Regret Vaccine
//
//  Created by 윤무영 on 9/26/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @State var userName: String
    @State var userAge: Float
    @State var expectedLifespan: Float
    
    @State var isPresented: Bool = false
    
    var body: some View {
        List {
            Section(header: EmptyView()) {
                UserProfileView(showingName: userName, showingAge: userAge, showingExpectedLifespan: expectedLifespan)
                    .onTapGesture {
                        isPresented.toggle()
                    }
                    .sheet(isPresented: $isPresented) {
                        InputUserInfoView()
                    }
            }
            Section(header: Text("Events")) {
                RemainingChristmasView()
            }
        }
    }
}
    
#Preview {
    HomeView(userName: "YUN", userAge: 21, expectedLifespan: 87)
}

