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
            UserDefaults.standard.set(userName, forKey: "userName")
        }
    }
    
    @Published var userSex: String {
        didSet {
            UserDefaults.standard.set(userSex, forKey: "userSex")
        }
    }
    
    @Published var userBirthDate: Date {
        didSet {
            UserDefaults.standard.set(userBirthDate, forKey: "userBirthDate")
        }
    }
    
    @Published var userDeadDate: Date {
        didSet {
            UserDefaults.standard.set(userDeadDate, forKey: "userDeadDate")
        }
    }
    
    init() {
        self.userName = UserDefaults.standard.string(forKey: "userName") ?? ""
        self.userSex = UserDefaults.standard.string(forKey: "userSex") ?? ""
        self.userBirthDate = UserDefaults.standard.object(forKey: "userBirthDate") as? Date ?? Date.now
        self.userDeadDate = UserDefaults.standard.object(forKey: "userDeadDate") as? Date ?? Date.now
    }
}
