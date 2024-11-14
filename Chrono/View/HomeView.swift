//
//  ContentView.swift
//  Regret Vaccine
//
//  Created by 윤무영 on 9/26/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @State var isPresented: Bool = false
    
    var body: some View {
        List {
            Section(header: EmptyView()) {
                UserProfileView(userProfile: UserProfile())
                    .onTapGesture {
                        isPresented.toggle()
                    }
                    .sheet(isPresented: $isPresented) {
                        InputUserInfoView()
                    }
            }
            Section(header: Text("Events")) {
                NextChristmasView()
            }
        }
    }
}
    
#Preview {
    HomeView()
}

