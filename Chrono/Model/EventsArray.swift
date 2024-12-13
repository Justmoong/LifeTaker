//
//  EventsArray.swift
//  Chrono
//
//  Created by 윤무영 on 12/13/24.
//


import SwiftUI

class EventsArray: ObservableObject {
    
    @Published var events: [EventsProperties] = []
    let calendar = ChronoCalendar()
    
    init(events: [EventsProperties] = []) {
        self.events = events
        christmas()
        monday()
    }
    
    private func christmas() {
        let christmas = EventsProperties()
        christmas.name = "Christmas"
        christmas.DDay = ChrisrtmasProperties.remainingChristmasDays()
        christmas.gaugeValue = ChrisrtmasProperties.daysPassedInYear()
        christmas.max = calendar.lengthOfYear()
        self.events.append(christmas)
    }
    
    func monday() {
            let monday = EventsProperties()
            monday.name = "Mondays"
            monday.DDay = MondayProperties.remainingMondaysInYear()
            monday.gaugeValue = MondayProperties.totalMondaysInYear() - MondayProperties.remainingMondaysInYear()
            monday.max = MondayProperties.totalMondaysInYear()
            self.events.append(monday)
        }
}
