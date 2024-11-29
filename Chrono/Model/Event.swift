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
}

