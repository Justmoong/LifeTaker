//
//  UserProfile.swift
//  Chrono
//
//  Created by 윤무영 on 11/8/24.
//

import Foundation

class UserData: ObservableObject, Codable {
    @Published var userName: String
    @Published var userSex: String
    @Published var userAge: Int
    @Published var userBirthday: Date
    @Published var userDeathAge: Int
    @Published var userExpectedLifespan: Int

    init(userName: String, userSex: String, userAge: Int, userBirthday: Date, userDeathAge: Int, userExpectedLifespan: Int) {
        self.userName = userName
        self.userSex = userSex
        self.userAge = userAge
        self.userBirthday = userBirthday
        self.userDeathAge = userDeathAge
        self.userExpectedLifespan = userExpectedLifespan
    }
    
    // Custom encoder/decoder to handle @Published properties
    private enum CodingKeys: String, CodingKey {
        case userName, userSex, userAge, userBirthday, userDeathAge, userExpectedLifespan
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userName = try container.decode(String.self, forKey: .userName)
        userSex = try container.decode(String.self, forKey: .userSex)
        userAge = try container.decode(Int.self, forKey: .userAge)
        userBirthday = try container.decode(Date.self, forKey: .userBirthday)
        userDeathAge = try container.decode(Int.self, forKey: .userDeathAge)
        userExpectedLifespan = try container.decode(Int.self, forKey: .userExpectedLifespan)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(userName, forKey: .userName)
        try container.encode(userSex, forKey: .userSex)
        try container.encode(userAge, forKey: .userAge)
        try container.encode(userBirthday, forKey: .userBirthday)
        try container.encode(userDeathAge, forKey: .userDeathAge)
        try container.encode(userExpectedLifespan, forKey: .userExpectedLifespan)
    }
}
