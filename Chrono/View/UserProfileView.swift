//
//  UserInfoHeaderView.swift
//  Chrono
//
//  Created by 윤무영 on 11/8/24.
//

import SwiftUI

struct UserProfileView: View {
    
    @Binding var showingName : String
    @Binding var userAge : Float
    @Binding var userBirthDay : Date
    @Binding var userExpectedLifespan : Float
    
    private static let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd"
           return formatter
       }()
    
    var body: some View {
        VStack (alignment: .leading, spacing: 16){
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width:48 , height:  48)
                VStack (alignment: .leading){
                    Text(showingName)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text(Self.dateFormatter.string(from: userBirthDay))
                        .font(.subheadline)
                        .foregroundStyle(Color.gray)
                }
                Spacer()
                Gauge(value: Double(userAge),  in: 0...Double(userExpectedLifespan)) {
                    Text("\(userAge)") //나이가 표시되어야 한다.
                        .font(.headline)
                }
                .gaugeStyle(.accessoryCircularCapacity)
                .foregroundStyle(Color.accentColor)
                .tint(Color.accentColor)
            }
            HStack{
                Gauge(value: userAge,  in: 0...userExpectedLifespan) {
                    
                }
                .gaugeStyle(.accessoryLinearCapacity)
                .tint(Color.accentColor)
            }
        }
    }
}

#Preview {
    UserProfileView(
        showingName: .constant(""),
        userAge: .constant(29),
        userBirthDay: .constant(Date()),
        userExpectedLifespan: .constant(100)
    )
}
