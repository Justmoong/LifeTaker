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
}

// MARK: func RemainingLife


