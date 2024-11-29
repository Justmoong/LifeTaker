//
//  CalcRemainingMondays.swift
//  Chrono
//
//  Created by 윤무영 on 11/29/24.
//

import Foundation
import SwiftUI

//@Binding var totalMondays: Int
//@Binding var pastMondays: Int
//@Binding var remainingMondays: Int

//private var debug_totalMondays: Int = calculateMondays(userBirthDay: Date(), userExpectedLifespan: 80, userAge: 0).totalMondays
//private var debug_pastMondays: Int = calculateMondays(userBirthDay: Date(), userExpectedLifespan: 80, userAge: 0).pastMondays
//private var debug_remainingMondays: Int = calculateMondays(userBirthDay: Date(), userExpectedLifespan: 80, userAge: 0).remainingMondays

public func calculateMondays(userBirthDay: Date, userExpectedLifespan: Int, userAge: Int) -> (totalMondays: Int, pastMondays: Int, remainingMondays: Int) {
    let calendar = Calendar.current

    // 사용자 사망 예정일 계산
    guard let deathDate = calendar.date(byAdding: .year, value: userExpectedLifespan, to: userBirthDay) else {
        print("[calculateMondays] Failed to calculate death date.")
        return (0, 0, 0)
    }
    let now = Date()
    var totalMondays = 0
    var pastMondays = 0
    // 날짜 순회 방법으로 계산
    var date = userBirthDay
    while date <= deathDate {
        if calendar.component(.weekday, from: date) == 2 { // 월요일은 weekday = 2
            totalMondays += 1
            if date <= now {
                pastMondays += 1
            }
        }
        date = calendar.date(byAdding: .day, value: 1, to: date)!
    }
    let remainingMondays = totalMondays - pastMondays

    return (totalMondays, pastMondays, remainingMondays)
}

//변수에 따로 저장하면 코드가 매우 구려지므로 분리 함수로 해결
//사용할 때 var varName = func(Bindied value)로 사용
public func totalMondays(userBirthDay: Date, userExpectedLifespan: Int) -> Int {
    let result = calculateMondays(userBirthDay: userBirthDay, userExpectedLifespan: userExpectedLifespan, userAge: 0)
    print("Total Mondays: \(result.totalMondays)")
    return result.totalMondays
}

public func pastMondays(userBirthDay: Date, userExpectedLifespan: Int) -> Int {
    let result = calculateMondays(userBirthDay: userBirthDay, userExpectedLifespan: userExpectedLifespan, userAge: 0)
    print("Past Mondays: \(result.pastMondays)")
    return result.pastMondays
}

public func remainingMondays(userBirthDay: Date, userExpectedLifespan: Int) -> Int {
    let result = calculateMondays(userBirthDay: userBirthDay, userExpectedLifespan: userExpectedLifespan, userAge: 0)
    print("Remaining Mondays: \(result.remainingMondays)")
    return result.remainingMondays
}



