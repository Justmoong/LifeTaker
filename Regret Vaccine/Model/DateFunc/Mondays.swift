//
//  Mondays.swift
//  Regret Vaccine
//
//  Created by 윤무영 on 9/29/24.
//

import Foundation

func calculateRemainingMondays(birthday: String, lifeExpectancy: Int) -> Int? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    // 생일을 Date 타입으로 변환
    guard let birthDate = dateFormatter.date(from: birthday) else {
        print("잘못된 날짜 형식입니다.")
        return nil
    }
    
    let calendar = Calendar.current
    let currentDate = Date()
    
    // 기대 수명을 기준으로 사용자의 생을 마감하는 날짜 계산
    //남은 수명은 따로 계산해야 한다.
    guard let lifeEndDate = calendar.date(byAdding: .year, value: lifeExpectancy, to: birthDate) else {
        print("수명 계산 실패.")
        return nil
    }
    
    // 현재 날짜가 생일보다 이전이라면 생일로 시작 날짜를 변경
    let startDate = currentDate > birthDate ? currentDate : birthDate
    
    // 남은 월요일의 개수를 추적할 변수
    var remainingMondays = 0
    
    // 현재 날짜부터 수명 끝까지 반복해서 월요일을 찾기
    var nextMonday = calendar.nextDate(after: startDate, matching: DateComponents(weekday: 2), matchingPolicy: .nextTime)
    
    // 남은 수명 안에 있는 모든 월요일을 계산
    while let monday = nextMonday, monday <= lifeEndDate {
        remainingMondays += 1
        nextMonday = calendar.date(byAdding: .weekOfYear, value: 1, to: monday)
    }
    
    return remainingMondays
}

//// 테스트 실행
//if let mondays = calculateRemainingMondays(birthday: "2002-05-04", lifeExpectancy: 80) {
//    print("남은 월요일의 개수: \(mondays)개")
//} else {
//    print("월요일을 계산할 수 없습니다.")
//}
