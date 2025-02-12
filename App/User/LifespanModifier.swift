//
//  LifespanModifier.swift
//  Chrono
//
//  Created by ymy on 2/12/25.
//

import Foundation
import Combine
import SwiftUICore

class LifespanModifier: ObservableObject {
    @ObservedObject var userData: UserData
    @ObservedObject var healthData: HealthManager

    var heartRateScore: Int = 0
    var stepCountScore: Int = 0
    var sleepScore: Int = 0
    var caloriesScore: Int = 0

    init(userData: UserData, healthModel: HealthManager) {
            self.userData = userData
            self.healthData = healthModel
            self.updateModifiers()
    }
    
    func updateModifiers() {
        heartRateScore = modifiedByHeartRate()
        stepCountScore = modifiedByStepCount()
        sleepScore = modifiedBySleep()
        caloriesScore = modifiedByCalories()
    }

    func modifiedByHeartRate() -> Int {
        guard let heartRate = healthData.heartRate else { return 0 }
        
        let score: Int
        if heartRate < 50 {
            score = -4
        } else if 50...69 ~= heartRate {
            score = 2
        } else if 70...89 ~= heartRate {
            score = 1
        } else if 90...99 ~= heartRate {
            score = 0
        } else if 100...119 ~= heartRate {
            score = -2
        } else {
            score = -4
        }
        
        print(#file, #line, #function, "Heart rate score: \(score)")
        heartRateScore = score
        return score
    }

    func modifiedByStepCount() -> Int {
        guard let stepCount = healthData.stepCount else { return 0 }
        
        let score: Int
        if stepCount < 3000 {
            score = -4
        } else if 3000...4999 ~= stepCount {
            score = -2
        } else if 5000...7999 ~= stepCount {
            score = 1
        } else if 8000...9999 ~= stepCount {
            score = 2
        } else if 10000...11999 ~= stepCount {
            score = 4
        } else if 12000...15000 ~= stepCount {
            score = 5
        } else {
            score = 3
        }
        
        print(#file, #line, #function, "Step count score: \(score)")
        stepCountScore = score
        return score
    }

    func modifiedBySleep() -> Int {
        guard let sleep = healthData.sleepDuration else { return 0 }
        
        let score: Int
        if sleep < 4 {
            score = -6
        } else if 4...5 ~= sleep {
            score = -4
        } else if 5...6 ~= sleep {
            score = -2
        } else if 6...7 ~= sleep {
            score = 1
        } else if 7...9 ~= sleep {
            score = 3
        } else if 9...10 ~= sleep {
            score = 1
        } else {
            score = -2
        }
        
        print(#file, #line, #function, "Sleep score: \(score)")
        sleepScore = score
        return score
    }

    func modifiedByCalories() -> Int {
        guard let calories = healthData.activeCalories else { return 0 }
        
        let score: Int
        if calories < 300 {
            score = -4
        } else if 300...499 ~= calories {
            score = -2
        } else if 500...799 ~= calories {
            score = 1
        } else if 800...1199 ~= calories {
            score = 3
        } else if 1200...1499 ~= calories {
            score = 4
        } else if 1500...2000 ~= calories {
            score = 3
        } else {
            score = 1
        }
        
        print(#file, #line, #function, "Calories score: \(score)")
        caloriesScore = score
        return score
    }
    
    func updateLifeSpan() {
        let finalScore = heartRateScore + stepCountScore + sleepScore + caloriesScore
        
        let updatedDeathAge = userData.deathAge + finalScore

        if let adjustedDeathDate = Calendar.current.date(byAdding: .year, value: finalScore, to: userData.deathDate) {
            userData.deathDate = adjustedDeathDate
        }
        
        print(#file, #line, #function, "Total Score: \(finalScore), Updated deathAge: \(updatedDeathAge), Updated deathDate: \(userData.deathDate)")
    }
}
