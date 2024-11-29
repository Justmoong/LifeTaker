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
    var progressValue: Int
    var min: Int
    var max: Int
}
