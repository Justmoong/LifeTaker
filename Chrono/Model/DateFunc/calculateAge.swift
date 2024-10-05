//
//  calculateAge.swift
//  Chrono
//
//  Created by 윤무영 on 10/4/24.
//

//import Foundation
//
//func remainingLife() -> Int? {
//    guard let birthDate = UserLifeInfo.birthDate,
//          let endDate = UserLifeInfo.endDate else {
//        return nil // If either date is not set, return nil.
//    }
//    
//    let calendar = Calendar.current
//    let today = Date()
//    
//    // Calculate the number of days from today to the end date.
//    if today <= endDate {
//        let remainingComponents = calendar.dateComponents([.day], from: today, to: endDate)
//        return remainingComponents.day
//    } else {
//        return 0 // If the end date is in the past, return 0.
//    }
//}
//
