//
//  DateCalculator.swift
//  Chrono
//
//  Created by 윤무영 on 10/4/24.
//

import Foundation

// 1900년 1월 1일을 기준으로 하는 Date 객체 생성
let calendar = Calendar.current
let referenceDateComponents = DateComponents(year: 1900, month: 1, day: 1)
let referenceDate = calendar.date(from: referenceDateComponents)!

// 현재 날짜
let currentDate = Date()

// 현재 날짜와 1900년 1월 1일 사이의 초 차이 계산
let timeIntervalSince1900 = currentDate.timeIntervalSince(referenceDate)

// 초 단위를 Int로 변환
let intTimeStamp = Int(timeIntervalSince1900)

//print(intTimeStamp) // 출력: 현재 날짜와 시간의 타임스탬프 (1900년 기준)
