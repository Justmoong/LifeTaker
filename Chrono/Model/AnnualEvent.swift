//
//  AnnualEvent.swift
//  Chrono
//
//  Created by 윤무영 on 11/29/24.
//

import Foundation

struct AnnualEvent: Identifiable, Codable {
    let id = UUID()
    var name: String
    var dDay: Int
    var gaugeValue: Int
    var min: Int
    var max: Int
}
