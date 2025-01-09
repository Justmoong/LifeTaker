// MARK: 다음 크리스마스까지 남은 시간 계산

import Foundation

let calendar = Calendar.current
let now = Date()

// 현재 날짜의 연도, 월, 일을 추출
let currentYear = calendar.component(.year, from: now)
let currentMonth = calendar.component(.month, from: now)
let currentDay = calendar.component(.day, from: now)

// 다음 크리스마스의 연도 설정
var christmasYear = currentYear
if currentMonth > 12 || (currentMonth == 12 && currentDay > 25) {
    christmasYear += 1
}

// 다음 크리스마스 날짜 생성
var christmasComponents = DateComponents()
christmasComponents.year = christmasYear
christmasComponents.month = 12
christmasComponents.day = 25

guard let nextChristmas = calendar.date(from: christmasComponents) else {
    fatalError("크리스마스 날짜를 생성할 수 없습니다.")
}

// 두 날짜 간의 차이 계산
let components = calendar.dateComponents([.day, .hour, .minute, .second], from: now, to: nextChristmas)

if let days = components.day,
   let hours = components.hour,
   let minutes = components.minute,
   let seconds = components.second {
    print("다음 크리스마스까지 남은 시간: \(days)일 \(hours)시간 \(minutes)분 \(seconds)초")
}


//  MARK: 생애 동안 남은 크리스마스 일 수 계산


func remainingChristmases(currentAge: Int, expectedLifespan: Int) -> Int {
    let calendar = Calendar.current
    let now = Date()
    let currentYear = calendar.component(.year, from: now)
    let currentMonth = calendar.component(.month, from: now)
    let currentDay = calendar.component(.day, from: now)
    
    // 현재 연도에서 남은 생애 연도 계산
    let remainingYears = expectedLifespan - currentAge
    var remainingChristmases = remainingYears
    
    // 현재 날짜가 12월 25일 이후인지 확인
    if currentMonth > 12 || (currentMonth == 12 && currentDay > 25) {
        remainingChristmases -= 1
    }
    
    return remainingChristmases
}

// 사용 예시
let currentAge = 22
let expectedLifespan = 89
let remaining = remainingChristmases(currentAge: currentAge, expectedLifespan: expectedLifespan)
print("남은 크리스마스의 수: \(remaining)")

