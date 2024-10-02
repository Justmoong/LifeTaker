//
//  Christmas.swift
//  Regret Vaccine
//
//  Created by 윤무영 on 9/29/24.
//
import Foundation


func calculateRemainingChristmasDays(birthday: String, lifeExpectancy: Int) -> Int? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    // 사용자의 생일을 Date 타입으로 변환
    guard let birthDate = dateFormatter.date(from: birthday) else {
        print("잘못된 날짜 형식입니다.")
        return nil
    }
    
    let calendar = Calendar.current
    let currentDate = Date()
    
    // 사용자가 80세까지 산다고 가정
    guard let lifeEndDate = calendar.date(byAdding: .year, value: lifeExpectancy, to: birthDate) else {
        print("수명 계산 실패.")
        return nil
    }
    
    // 현재 연도의 크리스마스 날짜 설정
    let currentYear = calendar.component(.year, from: currentDate)
    guard let thisChristmas = calendar.date(from: DateComponents(year: currentYear, month: 12, day: 25)) else {
        print("크리스마스 날짜 계산 실패.")
        return nil
    }
    
    // 만약 크리스마스가 이미 지났다면, 다음 해의 크리스마스를 계산
    let christmasDate: Date
    if thisChristmas < currentDate {
        guard let nextChristmas = calendar.date(from: DateComponents(year: currentYear + 1, month: 12, day: 25)) else {
            print("다음 크리스마스 날짜 계산 실패.")
            return nil
        }
        christmasDate = nextChristmas
    } else {
        christmasDate = thisChristmas
    }
    
    // 크리스마스까지 남은 일수 계산
    let remainingDays = calendar.dateComponents([.day], from: currentDate, to: christmasDate).day
    
    // 생명 종료일과 비교하여, 크리스마스가 그 이후라면 해당 값을 반환
    if christmasDate <= lifeEndDate {
        return remainingDays
    } else {
        print("생명 종료일 이후의 크리스마스입니다.")
        return nil
    }
}

// 테스트 예시
//if let remainingDays = calculateRemainingChristmasDays(birthday: "2002-05-04", lifeExpectancy: 80) {
//    print("남은 크리스마스까지 \(remainingDays)일 남았습니다.")
//} else {
//    print("크리스마스를 계산할 수 없습니다.")
//}
