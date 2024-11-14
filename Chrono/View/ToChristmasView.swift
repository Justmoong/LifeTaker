//
//  ToChristmas.swift
//  Regret Vaccine
//
//  Created by 윤무영 on 9/27/24.
//

import SwiftUI

struct ToChristmasView: View {
    @State private var daysUntilChristmas: Int = 0
    
    let christmas: Date = {
        //캘린더 호출
        let calendar = Calendar.current
        //크리스마스 날짜를 컴포넌트로
        let eventDay = DateComponents(year: calendar.component(.year, from: Date()), month: 12, day: 25)
        //반환
        return calendar.date(from: eventDay)!
    }()
    
    var body: some View {
            HStack (alignment: .center) {
                Text("To Christmas")
                    .padding()
                
                Text("\(daysUntilChristmas)")
                    .foregroundStyle(Color.accentColor)
            }
            .frame(maxWidth: .infinity)
            .cornerRadius(12)
            .onAppear(perform: calculateDaysUntilChristmas)
            .padding()
            
        }

    
    func calculateDaysUntilChristmas() {
        //현재 캘린더 담기
        let calendar = Calendar.current
        //현재 날짜 계산
        let today = Date()
        //오늘부터 크리스마스까지의 날짜 차이를 일 단위로 계산하여 결과값 반환
        if let days = calendar.dateComponents([.day], from: today, to: christmas).day {
            //계산된 일수와 0 중 큰 값을 선택하여 변수에 저장 (음수 방지)
            daysUntilChristmas = max(0, days)
        }
    }
}


#Preview {
    ToChristmasView()
}
