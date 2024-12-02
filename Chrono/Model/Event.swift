//
//  AnnualEvent.swift
//  Chrono
//
//  Created by 윤무영 on 11/29/24.
//

import Foundation

struct Event: Identifiable, Codable {
    var id = UUID()
    var name: String
    var DDay: Int
    var gaugeValue: Int
    var min: Int
    var max: Int
    
    static var defaultData: Event {
        Event(
            name: "",
            DDay: 0,
            gaugeValue: 0,
            min: 0,
            max: 0
        )
    }
}

class EventDataManager: ObservableObject {
    @Published var events: [Event] = [Event.defaultData] {
        didSet {
            saveEventData()
        }
    }
    
    
    private let eventDefaultsKey = "EventData"
    private let eventDefaults = UserDefaults(suiteName: "group.com.moonglab.chrono")
    
    init() {
        loadEventData()
    }
    
    private func saveEventData() {
        guard let encodedData = try? JSONEncoder().encode(events) else {
            print("Failed to encode event data.")
            return
        }
        eventDefaults?.set(encodedData, forKey: eventDefaultsKey)
    }
    
    private func loadEventData() {
        guard let savedData = eventDefaults?.data(forKey: eventDefaultsKey),
              let decodedData = try? JSONDecoder().decode([Event].self, from: savedData) else {
            print("No event data found, loading default data.")
            return
        }
        events = decodedData
    }
}

extension EventDataManager {
    func updateMondayEvent() {
        let totalMondays = UserDefaults.standard.integer(forKey: "totalMondays")
        let pastMondays = UserDefaults.standard.integer(forKey: "pastMondays")
        let remainingMondays = UserDefaults.standard.integer(forKey: "remainingMondays")
        
        let mondayEvent = Event(
            name: "Remaining Mondays",
            DDay: remainingMondays,
            gaugeValue: pastMondays,
            min: 0,
            max: totalMondays
        )
        
        // Update the event list
        if let index = events.firstIndex(where: { $0.name == "Remaining Mondays" }) {
            events[index] = mondayEvent
        } else {
            events.append(mondayEvent)
        }
        
        saveEventData()
        print("Debug info: [updateMondayEvent] Monday event updated: \(mondayEvent)")
    }
}

