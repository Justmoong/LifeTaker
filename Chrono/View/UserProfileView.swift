//
//  UserInfoHeaderView.swift
//  Chrono
//
//  Created by 윤무영 on 11/8/24.
//

import SwiftUI

struct UserProfileView: View {
    
    @StateObject var userData = UserData()
    
    var body: some View {
        VStack (alignment: .leading, spacing: 16){
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width:48 , height:  48)
                VStack (alignment: .leading){
                    Text(userData.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(
                        userData.name
                    )
                        .font(.subheadline)
                        .foregroundStyle(Color.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                // TODO: Sex Icon will place here!!!!!!
                .frame(maxWidth: .infinity, alignment: .leading)
                Gauge(value: Double(userData.age),  in: 0...Double(userData.deathAge)) {
                    Text(String(format: "%.0f", Double(userData.age)))
                        .font(.headline)
                }
                        .gaugeStyle(.accessoryCircularCapacity)
                        .foregroundStyle(Color.accentColor)
                        .tint(Color.accentColor)
            }
            HStack{
                Gauge(value: Float(userData.age),  in: 0...Float(userData.deathAge)) {
                    
                }
                .gaugeStyle(.accessoryLinearCapacity)
                .tint(Color.accentColor)
            }
        }
    }
}

#Preview {
    UserProfileView(userData: UserData())
}
