//
//  ContentView.swift
//  Regret Vaccine
//
//  Created by 윤무영 on 9/26/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    
    var body: some View {
        List {
            InputUserInfoView(userBirthday: Date(), userSex: "male")
            ToChristmasView()
        }
    }
}
    
#Preview {
    HomeView()
}

