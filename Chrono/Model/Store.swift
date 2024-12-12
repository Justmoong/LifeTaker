//
//  Store.swift
//  Chrono
//
//  Created by 윤무영 on 12/10/24.
//

import Foundation


let appGroup = "group.com.moonglab.chrono"
let sharedDefaults = UserDefaults(suiteName: appGroup)

@MainActor func saveUserData(userData: UserData) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(userData) {
        sharedDefaults?.set(encoded, forKey: "UserData")
    }
}

@MainActor func loadUserData() -> UserData? {
    if let data = sharedDefaults?.data(forKey: "UserData") {
        let decoder = JSONDecoder()
        return try? decoder.decode(UserData.self, from: data)
    }
    return nil
}
