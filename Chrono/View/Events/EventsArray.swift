//
//  EventsArray.swift
//  Chrono
//
//  Created by 윤무영 on 12/13/24.
//


import SwiftUI

class EventsArray: ObservableObject {
    @Published var events: [EventsProperties] = []
    
    init(events: [EventsProperties] = []) {
        self.events = events
    }
}