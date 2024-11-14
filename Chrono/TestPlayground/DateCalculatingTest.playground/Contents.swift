import Foundation
import SwiftUI

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter
}()
//남은 월요일 계산
func calculateRemainingMondays(birthday: String, lifeExpectancy: Int) -> Int? {
    
    guard let birthDate = dateFormatter.date(from: birthday) else {
        return nil
    }
    
    let calendar = Calendar.current
    let endDate = calendar.date(byAdding: .year, value: lifeExpectancy, to: birthDate)!
    
    var mondaysCount = 0
    var currentDate = Date()
    
    while currentDate <= endDate {
        if calendar.component(.weekday, from: currentDate) == 2 { // 월요일은 2
            mondaysCount += 1
        }
        currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
    }
    
    return mondaysCount
}
var remainingMondays: Int = calculateRemainingMondays(birthday: "2002-05-04 09:21:45", lifeExpectancy: 80)!
print("남은 월요일: \(remainingMondays)")



// Date 객체 생성
let calendar = Calendar.current
let referenceDateComponents = DateComponents(year: 2002, month: 5, day: 4)
let referenceDate = calendar.date(from: referenceDateComponents)!
// 날짜 구성 요소 추출
let components =  calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateFormatter.date(from: "2002-05-04 09:21:45")!)

// 각 구성 요소를 숫자로 사용
let year = components.year
let month = components.month
let day = components.day
let hour = components.hour
let minute = components.minute
let second = components.second

print("Year: \(String(describing: year)), Month: \(String(describing: month)), Day: \(String(describing: day))")
print("Hour: \(String(describing: hour)), Minute: \(String(describing: minute)), Second: \(String(describing: second))")




// 현재 날짜
let currentDate = Date()

// 현재 날짜와 1900년 1월 1일 사이의 초 차이 계산
let timeIntervalSince1900 = currentDate.timeIntervalSince(referenceDate)

// 초 단위를 Int로 변환
let intSecondStamp = Int(timeIntervalSince1900)
// 분 단위를 Int로 변환
let intMinuteStamp = Int(timeIntervalSince1900 / 60)
// 시간 단위를 Int로 변환
let intHourStamp = Int(timeIntervalSince1900 / 3600)
// 일 단위를 Int로 변환
let intDayStamp = Int(timeIntervalSince1900 / 86400)
// 주 단위를 Int로 변환
let intWeekStamp = Int(timeIntervalSince1900 / 604800)
// 개월 단위를 Int로 변환
let intMonthStamp = Int(timeIntervalSince1900 / 2592000)
// 분기 단위를 Int로 변환
let intQuarterStamp = Int(timeIntervalSince1900 / 7776000)


print("남은 인생의 초: \(intSecondStamp)")
print("남은 인생의 분: \(intMinuteStamp)")
print("남은 인생의 시간: \(intHourStamp)")
print("남은 인생의 일: \(intDayStamp)")
print("남은 인생의 주: \(intWeekStamp)")
print("남은 인생의 월: \(intMonthStamp)")
print("남은 인생의 분기: \(intQuarterStamp)")
//출력 결과가 무언가 이상함
