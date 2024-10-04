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
    @State private var endhDate = Date()
//아마 날짜 피커를 뷰에 바인딩해야 할 것
    
    
      var body: some View {
          HStack (alignment: .center) {
//              Text("\(user.birthDate ?? Date(), formatter: dateFormatter)")
//
//                  
              
//              
//              Text("\(user.endDate ?? Date(), formatter: dateFormatter)")

              VStack (alignment: .leading) {
                  Text("Birthday")
                  DatePicker("", selection: $birthDate, displayedComponents: .date)
                      .labelsHidden()
              }
              
              Spacer()
              
              VStack (alignment: .trailing) {
                  Text("End Date")
                  DatePicker("", selection: $endhDate, displayedComponents: .date)
                      .labelsHidden()
              }
                  
          }
          .padding()
      }
  }

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()

#Preview {
    // 프리뷰를 위한 임시 뷰를 사용하여 userName에 초기값을 설정
    UserInfoHeaderView()
}

