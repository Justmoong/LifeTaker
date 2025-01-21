//
//  UserProfile.swift
//  Chrono
//
//  Created by 윤무영 on 11/8/24.
//

import Foundation
import Combine

final class UserData: ObservableObject {
    @Published var name: String = ""
    @Published var birthday: Date = Date()
    @Published var deathDate: Date = Date()
    @Published var age: Int = 0
    @Published var deathAge: Int = 0
    @Published var sex: String = "Male"
    
    private let userDefaultsKey = "UserData"
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadFromUserDefaults()
        
        $name
            .sink { [weak self] _ in
                self?.saveToUserDefaults()
            }
            .store(in: &cancellables)

        $birthday
            .sink { [weak self] _ in
                self?.saveToUserDefaults()
            }
            .store(in: &cancellables)

        $deathDate
            .sink { [weak self] _ in
                self?.saveToUserDefaults()
            }
            .store(in: &cancellables)

        $sex
            .sink { [weak self] _ in
                self?.saveToUserDefaults()
            }
            .store(in: &cancellables)
    }
    
    func setAge() {
        let calendar = Calendar.current
        let now = Date()
        let calculatedAge = calendar.dateComponents([.year], from: birthday, to: now).year ?? 0
        self.age = calculatedAge
    }
    
    func setDeathDate() {
        let lifeExpectancy: Int
        switch sex {
        case "Male":
            lifeExpectancy = 80
        case "Female":
            lifeExpectancy = 89
        default:
            lifeExpectancy = 80
        }
        
        deathAge = lifeExpectancy
        
        if let deathDate = Calendar.current.date(byAdding: .year, value: lifeExpectancy, to: birthday) {
            self.deathDate = deathDate
        } else {
            print("Error: Failed to calculate death date.")
        }
    }
    
    // MARK: - UserDefaults
    private func saveToUserDefaults() {
        let encoder = JSONEncoder()
        let snapshot = UserDataSnapshot(
            name: name,
            birthday: birthday,
            deathDate: deathDate,
            age: age,
            deathAge: deathAge,
            sex: sex
        )
        
        if let encoded = try? encoder.encode(snapshot) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func loadFromUserDefaults() {
        let decoder = JSONDecoder()
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let snapshot = try? decoder.decode(UserDataSnapshot.self, from: savedData) {
            self.name = snapshot.name
            self.birthday = snapshot.birthday
            self.deathDate = snapshot.deathDate
            self.age = snapshot.age
            self.deathAge = snapshot.deathAge
            self.sex = snapshot.sex
        }
    }
}

// MARK: - Codable Compability Struct
private struct UserDataSnapshot: Codable {
    var name: String
    var birthday: Date
    var deathDate: Date
    var age: Int
    var deathAge: Int
    var sex: String
}
