//
//  UserLife.swift
//  Regret Vaccine
//
//  Created by 윤무영 on 9/29/24.
//

import Foundation
import SwiftData

@Model
final class UserLifeInfo: ObservableObject {
    @Attribute(.unique) var id: UUID
    var age: Int?
    var sex: String?
    var birthDate: Date?
    var endDate: Date?
    
    init(id: UUID = UUID(), age: Int? = nil, sex: String? = nil, birthDate: Date? = nil, endDate: Date? = nil) {
        self.id = id
        self.age = age
        self.sex = sex
        self.birthDate = birthDate
        self.endDate = endDate
    }
    
    // MARK: func RemainingLife
    
    /// Calculates the remaining life in days from today to the end date.
    /// - Returns: The number of days remaining if both birthDate and endDate are set; otherwise, returns nil.
    func remainingLife() -> Int? {
        
        let calendar = Calendar.current
        let today = Date()
        
        // Calculate the number of days from today to the end date.
        if today <= endDate! {
            let remainingComponents = calendar.dateComponents([.day], from: today, to: endDate!)
            return remainingComponents.day
        } else {
            return 0 // If the end date is in the past, return 0.
        }
    }
}


