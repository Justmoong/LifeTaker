//
//  EventsProperties.swift
//  Chrono
//
//  Created by 윤무영 on 12/13/24.
//
import Foundation

class EventsProperties: Identifiable, ObservableObject {
    @Published var id = UUID()
    @Published var name: String
    @Published var count: Int
    @Published var gaugeValue: Int
    @Published var min: Int
    @Published var max: Int
    
    init(id: UUID = UUID(), name: String, count: Int, gaugeValue: Int, min: Int, max: Int) {
        self.id = id
        self.name = ""
        self.count = 1
        self.gaugeValue = 1
        self.min = 0
        self.max = 100
    }
}
