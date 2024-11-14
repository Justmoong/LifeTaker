//
//  UserProfile.swift
//  Chrono
//
//  Created by 윤무영 on 11/8/24.
//

import Foundation
import SwiftData

class UserProfile: ObservableObject {
    @Published var userName: String {
        didSet {
            print("Name changed to: \(userName)")
            objectWillChange.send()
        }
    }
    @Published var userSex: String
    @Published var userBirthDate: Date
    @Published var userDeadDate: Date
    
    init() {
        self.userName = UserDefaults.standard.string(forKey: "userName") ?? ""
        self.userSex = UserDefaults.standard.string(forKey: "userSex") ?? ""
        self.userBirthDate = UserDefaults.standard.object(forKey: "userBirthDate") as? Date ?? Date.now
        self.userDeadDate = UserDefaults.standard.object(forKey: "userDeadDate") as? Date ?? Date.now
    }
}
