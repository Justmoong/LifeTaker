//
//  UserProfile.swift
//  Chrono
//
//  Created by 윤무영 on 11/8/24.
//

import Foundation

final class UserData: ObservableObject {
    @Published var name: String = "" {
        didSet { saveToUserDefaults() }
    }
    @Published var birthday: Date = Date() {
        didSet {
            setAge()
            saveToUserDefaults()
        }
    }
    @Published var deathDate: Date = Date() {
        didSet { saveToUserDefaults() }
    }
    @Published var age: Int = 0 {
        didSet { saveToUserDefaults() }
    }
    @Published var deathAge: Int = 80 {
        didSet { saveToUserDefaults() }
    }
    @Published var sex: String = "Male" {
        didSet {
            setDeathDate()
            saveToUserDefaults()
        }
    }
    
    private let userDefaultsKey = "UserData"
    
    init() {
        loadFromUserDefaults()
    }
    
    func setAge() {
        let calculatedAge = Calendar.current.dateComponents([.year], from: birthday, to: Date()).year ?? 0
        self.age = calculatedAge
    }
    
    func setDeathDate() {
        let lifeExpectancy = (sex == "Female") ? 89 : 80
        self.deathAge = lifeExpectancy
        self.deathDate = Calendar.current.date(byAdding: .year, value: lifeExpectancy, to: birthday) ?? Date()
    }
    
    private var saveTask: DispatchWorkItem?

    private func saveToUserDefaults() {
        saveTask?.cancel()
        saveTask = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            let encoder = JSONEncoder()
            let snapshot = UserDataSnapshot(
                name: self.name,
                birthday: self.birthday,
                deathDate: self.deathDate,
                age: self.age,
                deathAge: self.deathAge,
                sex: self.sex
            )
            if let encoded = try? encoder.encode(snapshot) {
                UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
            }
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5, execute: saveTask!)
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

private struct UserDataSnapshot: Codable {
    var name: String
    var birthday: Date
    var deathDate: Date
    var age: Int
    var deathAge: Int
    var sex: String
}
