//
//  UserLifeCalc.swift
//  Chrono
//
//  Created by 윤무영 on 10/4/24.
//
import Foundation

//날짜 포맷 지정
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()

//현재 나이 구하기
func calculateAge(from birthDate: Date) -> Int {
        let calendar = Calendar.current
        let today = Date()
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: today)
        return ageComponents.year ?? 0
    }

//나이를 일수로 계산
func calculateAgeDays(start: Date, end: Date) -> Int {
    return Calendar.current.dateComponents([.day], from: start, to: end).day ?? 0
}




//func calculateRemainingLife(user: UserLifeInfo) -> Int? {
//    guard let birthDate = user.birthDate, let sex = user.sex else {
//        print("생년월일 또는 성별이 입력되지 않았습니다.")
//        return nil
//    }
//    
//    // 기대 수명 설정: 남성은 80년, 여성은 88년
//    let lifeExpectancy: Int
//    if sex.lowercased() == "male" {
//        lifeExpectancy = 80
//    } else if sex.lowercased() == "female" {
//        lifeExpectancy = 88
//    } else {
//        print("잘못된 성별이 입력되었습니다.")
//        return nil
//    }
//    
//    // 현재 날짜 가져오기
//    let currentDate = Date()
//    
//    // Calendar 객체 생성
//    let calendar = Calendar.current
//    
//    // 기대 수명을 생년월일에 더해 사망 예상 날짜 계산
//    guard let lifeEndDate = calendar.date(byAdding: .year, value: lifeExpectancy, to: birthDate) else {
//        print("수명 계산 중 오류가 발생했습니다.")
//        return nil
//    }
//    
//    // 남은 수명 계산 (일 단위)
//    let remainingLife = calendar.dateComponents([.day], from: currentDate, to: lifeEndDate).day
//    
//    return remainingLife
//}

//// 테스트 실행
//let user = UserLifeInfo(age: 22, sex: "male", birthDate: Date(timeIntervalSince1970: 1020384000)) // 2002-05-04
//if let remainingLife = calculateRemainingLife(user: user) {
//    print("남은 수명: \(remainingLife)일")
//} else {
//    print("남은 수명을 계산할 수 없습니다.")
//}

// MARK: func LifeEndDate

//
//func calculateLifeEndDate(user: UserLifeInfo) -> Date? {
//    guard let birthDate = user.birthDate, let sex = user.sex else {
//        print("생년월일 또는 성별이 입력되지 않았습니다.")
//        return nil
//    }
//    
//    // 성별에 따른 기대 수명 설정
//    let lifeExpectancy: Int
//    if sex.lowercased() == "male" {
//        lifeExpectancy = 80
//    } else if sex.lowercased() == "female" {
//        lifeExpectancy = 88
//    } else {
//        print("잘못된 성별이 입력되었습니다.")
//        return nil
//    }
//    
//    // Calendar 객체 생성 및 기대 수명 종료일 계산
//    let calendar = Calendar.current
//    guard let lifeEndDate = calendar.date(byAdding: .year, value: lifeExpectancy, to: birthDate) else {
//        print("수명 계산 중 오류가 발생했습니다.")
//        return nil
//    }
//    
//    return lifeEndDate
//}
