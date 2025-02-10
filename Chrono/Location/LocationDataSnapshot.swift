//
//  LocationDataSnapshot.swift
//  Chrono
//
//  Created by ymy on 2/5/25.
//


struct LocationDataSnapshot: Codable {
    var latitude: Double
    var longitude: Double
    var continent: String
    var country: String
    var continentLifeExpectancy: Int
}
