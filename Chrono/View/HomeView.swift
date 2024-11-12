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
            UserProfileView(userProfile: UserProfile())
                .onTapGesture {
                    isPresented.toggle()
                }
                .sheet(isPresented: $isPresented) {
                    InputUserInfoView()
                }
        }
    }
}
    
#Preview {
    HomeView()
}

