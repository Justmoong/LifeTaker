//
//  ContentView.swift
//  Regret Vaccine
//
//  Created by 윤무영 on 9/26/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @StateObject private var userData = UserData()
    @StateObject var eventList = EventsArray(events: [])
    
    @State var isPresented: Bool = false
    
    var body: some View {
        List {
            Section(header: EmptyView()) {
                UserProfileView(userData: userData)
                    .sheet(isPresented: $isPresented) {
                        InputUserInfoView()
                    }
                    .onTapGesture {
                        isPresented = true
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
