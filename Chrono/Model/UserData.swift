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
    
    func setAge() {
        let calendar = Calendar.current
        let now = Date()
        
        // 나이를 계산하여 업데이트
        let calculatedAge = calendar.dateComponents([.year], from: birthday, to: now).year ?? 0
        self.age = calculatedAge
    }
    
    func setDeathDate() {
            // 성별에 따른 기대수명 설정
            let lifeExpectancy: Int
            switch sex {
            case "Male":
                lifeExpectancy = 80
            case "Female":
                lifeExpectancy = 89
            default:
                lifeExpectancy = 80 // 기본값
            }
            
            deathAge = lifeExpectancy
            
            if let deathDate = Calendar.current.date(byAdding: .year, value: lifeExpectancy, to: birthday) {
                self.deathDate = deathDate
            } else {
                print("Error: Failed to calculate death date.")
            }
        }
}
