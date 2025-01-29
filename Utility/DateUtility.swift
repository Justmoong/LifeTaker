//
//  DateUtility.swift
//  Chrono
//
//  Created by ymy on 1/17/25.
//

import Foundation
import SwiftUI

var dateComponents = DateComponents()

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()

let lengthOfYear = daysInYear(for: dateComponents.year ?? 0)

func daysInYear(for year: Int) -> Int {
    // 윤년 여부를 판단하는 함수
    func isLeapYear(_ year: Int) -> Bool {
        if year % 4 == 0 {
            if year % 100 == 0 {
                return year % 400 == 0
            }
            return true
        }
        return false
    }
    
    // 윤년이면 366일, 그렇지 않으면 365일 반환
    return isLeapYear(year) ? 366 : 365
}


var now = Date()
let calendar = Calendar.current
