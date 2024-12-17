//
//  EventsProperties.swift
//  Chrono
//
//  Created by 윤무영 on 12/13/24.
//
import Foundation

class EventsProperties: Identifiable, ObservableObject {
    @Published var id = UUID()
    @Published var name = ""
    @Published var DDay = 0
    @Published var gaugeValue = 0
    @Published var min = 0
    @Published var max = 100
    
}
