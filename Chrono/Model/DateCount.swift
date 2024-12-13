//
//  AnnualEvent.swift
//  Chrono
//
//  Created by 윤무영 on 11/29/24.
//
import Foundation

class DateCount: ObservableObject, Codable {
    @Published var yearCount: Int
    @Published var monthCount: Int
    @Published var dayCount: Int
    @Published var hourCount: Int
    @Published var minCount: Int
    @Published var secCount: Int
    
    init(yearCount: Int, monthCount: Int, dayCount: Int, hourCount: Int, minCount: Int, secCount: Int) {
        self.yearCount = yearCount
        self.monthCount = monthCount
        self.dayCount = dayCount
        self.hourCount = hourCount
        self.minCount = minCount
        self.secCount = secCount
    }
    
    // Custom encoder/decoder to handle @Published properties
    private enum CodingKeys: String, CodingKey {
        case yearCount, monthCount, dayCount, hourCount, minCount, secCount
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        yearCount = try container.decode(Int.self, forKey: .yearCount)
        monthCount = try container.decode(Int.self, forKey: .monthCount)
        dayCount = try container.decode(Int.self, forKey: .dayCount)
        hourCount = try container.decode(Int.self, forKey: .hourCount)
        minCount = try container.decode(Int.self, forKey: .minCount)
        secCount = try container.decode(Int.self, forKey: .secCount)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(yearCount, forKey: .yearCount)
        try container.encode(monthCount, forKey: .monthCount)
        try container.encode(dayCount, forKey: .dayCount)
        try container.encode(hourCount, forKey: .hourCount)
        try container.encode(minCount, forKey: .minCount)
        try container.encode(secCount, forKey: .secCount)
    }
}

