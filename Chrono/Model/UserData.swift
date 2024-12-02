//
//  UserProfile.swift
//  Chrono
//
//  Created by 윤무영 on 11/8/24.
//

import Foundation

struct UserData: Codable {
    var userName: String
    var userAge: Int
    var userBirthDay: Date
    var expectedLifespan: Int
    var userSex: String
    
    // 기본값 생성
    static var defaultData: UserData {
        UserData(
            userName: "",
            userAge: 0,
            userBirthDay: Date(),
            expectedLifespan: 100,
            userSex: "Male"
        )
    }
}

// 사용자 데이터 관리 클래스
class UserDataManager: ObservableObject {
    @Published var userData: UserData = UserData.defaultData {
        didSet {
            saveUserData()
        }
    }
    
    private let userDefaultsKey = "UserData"
    private let userDefaults = UserDefaults(suiteName: "group.com.moonglab.chrono")!
    
    init() {
        loadUserData()
    }
    
    // 데이터 저장
    private func saveUserData() {
        guard let encodedData = try? JSONEncoder().encode(userData) else {
            print("Failed to encode user data.")
            return
        }
        userDefaults.set(encodedData, forKey: userDefaultsKey)
    }
    
    // 데이터 로드
    private func loadUserData() {
        guard let savedData = userDefaults.data(forKey: userDefaultsKey),
              let decodedData = try? JSONDecoder().decode(UserData.self, from: savedData) else {
            print("No user data found, loading default data.")
            return
        }
        userData = decodedData
    }
}
