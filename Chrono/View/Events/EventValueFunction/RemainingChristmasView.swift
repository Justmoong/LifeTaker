//
//  NextChristmasView.swift
//  Chrono
//
//  Created by 윤무영 on 11/14/24.
//
//import Foundation
//import SwiftUI
//
//struct RemainingChristmasView: View {
//    
//    //이 뷰는 user와 무관한 뷰이므로 바인딩하지 않는다.
//    
//    var body: some View {
//        VStack (alignment: .leading, spacing: 16) {
//            
//            HStack {
//                Text("Next Christmas")
//                    .font(.callout)
//                Spacer()
//                Text("\(remainingChristmasDays)")
//                    .foregroundStyle(Color.accentColor)
//                    .font(.title3)
//                    .fontWeight(.bold)
//            }
//            Gauge(value: Float(daysPassedThisYear), in: 1...365) {
//                Text("Progress to Christmas")
//            }
//            .gaugeStyle(.accessoryLinearCapacity)
//            .foregroundStyle(Color.accentColor)
//            .tint(Color.accentColor)
//            .labelsHidden()
//        }
//        .padding(.vertical, 8)
//        .onAppear {
//            // 매번 뷰가 나타날 때 날짜를 계산
//            remainingChristmasDays = daysUntilChristmas() + 1
//            //이유를 모르겠지만 계산 날짜가 하루 부족하여 1을 더하여 넘어간다.
//        }
//    }
//}
//
//
//#Preview {
//    RemainingChristmasView()
//}
