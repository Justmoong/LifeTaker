//
//  EventsProperties.swift
//  Chrono
//
//  Created by 윤무영 on 12/13/24.
//
import Foundation

class EventsProperties: Identifiable, ObservableObject {
    var id = UUID()
    var name = ""
    var DDay = 0
    var gaugeValue = 0
    var min = 0
    var max = 100
    
}
