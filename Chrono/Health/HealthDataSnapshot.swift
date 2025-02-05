//
//  HealthDataSnapshot.swift
//  Chrono
//
//  Created by ymy on 2/5/25.
//


struct HealthDataSnapshot: Codable {
    var heartRate: Double
    var stepCount: Double
    var activeCalories: Double
    var sleepDuration: Double
}