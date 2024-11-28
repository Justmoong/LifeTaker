//
//  UserInfoHeaderView.swift
//  Chrono
//
//  Created by 윤무영 on 11/8/24.
//

import SwiftUI

struct UserProfileView: View {
    
    @Binding var showingName : String
    @Binding var userAge : Int
    @Binding var userBirthDay : Date
    @Binding var userExpectedLifespan : Int
    
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
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(Self.dateFormatter.string(from: userBirthDay))
                        .font(.subheadline)
                        .foregroundStyle(Color.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                // TODO: Sex Icon will place here!!!!!!
                .frame(maxWidth: .infinity, alignment: .leading)
                Gauge(value: Double(userAge),  in: 0...Double(userExpectedLifespan)) {
                    Text(String(format: "%.0f", Double(userAge)))
                        .font(.headline)
                }
                        .gaugeStyle(.accessoryCircularCapacity)
                        .foregroundStyle(Color.accentColor)
                        .tint(Color.accentColor)
            }
            HStack{
                Gauge(value: Float(userAge),  in: 0...Float(userExpectedLifespan)) {
                    
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
        userAge: .constant(11),
        userBirthDay: .constant(Date()),
        userExpectedLifespan: .constant(100)
    )
}
