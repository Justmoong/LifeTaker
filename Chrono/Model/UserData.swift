//
//  UserProfile.swift
//  Chrono
//
//  Created by 윤무영 on 11/8/24.
//

import Foundation

class UserData: ObservableObject {
    @Published var name: String = ""
    @Published var birthday: Date = Date()
    @Published var deathDate: Date = Date()
    @Published var age: Int = 0
    @Published var deathAge: Int = 0
    @Published var sex: String = "Male"
}

