//
//  UserInfoHeaderView.swift
//  Chrono
//
//  Created by 윤무영 on 10/4/24.
//

import Foundation
import SwiftUI

struct UserInfoHeaderView: View {
    
//    @ObservedObject var user = UserLifeInfo(age: 22, sex: "male", birthDate: Date(), endDate: Date())
    @State private var birthDate = Date()
    @State private var endDate = Date()

    

      var body: some View {
          
          //상단에 유저 프로필 축
          HStack (alignment: .center) {
//              Text("\(user.birthDate ?? Date(), formatter: dateFormatter)")       
//              Text("\(user.endDate ?? Date(), formatter: dateFormatter)")

              VStack (alignment: .leading) {
                  Text("Birthday")
                  DatePicker("", selection: $birthDate, displayedComponents: .date)
                      .labelsHidden()
              }
              
              Spacer()
              
              VStack (alignment: .trailing) {
                  Text("End Date")
                  DatePicker("", selection: $endDate, displayedComponents: .date)
                      .labelsHidden()
              }
                  
          }
          .padding()
          
          let totalDays = calculateAgeDays(start: birthDate, end: endDate)
          let currentDays = calculateAgeDays(start: birthDate, end: Date())
                     let progress = totalDays > 0 ? Double(currentDays) / Double(totalDays) : 0
          
          
          //하단에 게이지 바 추가
          HStack (alignment: .center) {
              Text(calculateAge(from: birthDate).description)
                  .padding()
                  .font(.footnote)
              ProgressView(value: progress)
                           .progressViewStyle(LinearProgressViewStyle())
              
              let adjustedAge = calculateAge(from: birthDate) + 80
              //더하는 값은 남성일 경우 80 여성일 경우 88로 조건 분기
              
              Text(adjustedAge.description)
                  .padding()
                  .font(.footnote)
          }
         
      }
  }

//날짜 포맷 지정


//let yearFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateFormat = "yy"
//    return formatter
//}()








#Preview {
    // 프리뷰를 위한 임시 뷰를 사용하여 userName에 초기값을 설정
    UserInfoHeaderView()
}

