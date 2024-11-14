//
//  UserInfoHeaderView.swift
//  Chrono
//
//  Created by 윤무영 on 11/8/24.
//

import SwiftUI

struct UserProfileView: View {
    
    @StateObject var userProfile = UserProfile()
//    @StateObject var userProfile = UserProfile
//    @State var userName = UserProfile()
    @State var userAge: Float = 22
    @State var userDeadLine: Float = 89
    
    var body: some View {
        VStack (alignment: .leading, spacing: 16){
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width:48 , height:  48)
                VStack (alignment: .leading){
                    Text("\(userProfile.userName)")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("2002-05-04")
                        .font(.subheadline)
                        .foregroundStyle(Color.gray)
                }
                Spacer()
                Gauge(value: userAge,  in: 0...userDeadLine){
                    Text("29%") //나이와 사망나이를 나누기
                        .font(.headline)
                }
                .gaugeStyle(.accessoryCircularCapacity)
                .foregroundStyle(Color.accentColor)
                .tint(Color.accentColor)
            }
            HStack{
                Gauge(value: userAge,  in: 0...userDeadLine) {
                    
                }
                .gaugeStyle(.accessoryLinearCapacity)
                .tint(Color.accentColor)
            }
        }
    }
}

#Preview {
    UserProfileView()
}
