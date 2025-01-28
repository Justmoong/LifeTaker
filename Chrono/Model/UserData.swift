//
//  UserProfile.swift
//  Chrono
//
//  Created by 윤무영 on 11/8/24.
//

import Foundation
import Combine

class UserData: ObservableObject {
    @Published var name: String = "" {
        didSet { saveToUserDefaults() }
    }
    @Published var birthday: Date = Date() {
        didSet { saveToUserDefaults() }
    }
    @Published var deathDate: Date = Date() {
        didSet {
            calculateDeathAge()
            saveToUserDefaults()
        }
    }
    @Published var age: Int = 0 {
        didSet { saveToUserDefaults() }
    }
    @Published var deathAge: Int = 80 {
        didSet { saveToUserDefaults() }
    }
    @Published var sex: String = "Male" {
        didSet { saveToUserDefaults() }
    }
    
    private let userDefaultsKey = "UserData"
    private var cancellables: Set<AnyCancellable> = []

    init() {
        loadFromUserDefaults()
        setupBindings()
    }
    
    func setAge() {
        let calculatedAge = Calendar.current.dateComponents([.year], from: birthday, to: Date()).year ?? 0
        self.age = calculatedAge
    }
    
    func setDeathDate() {
        let lifeExpectancy: Int = (sex == "Female") ? 89 : 80
        self.deathDate = Calendar.current.date(byAdding: .year, value: lifeExpectancy, to: birthday) ?? Date()
    }
    
    private func calculateDeathAge() {
        let calculatedDeathAge = Calendar.current.dateComponents([.year], from: birthday, to: deathDate).year ?? 0
        self.deathAge = calculatedDeathAge
    }
    
    
    
    
    
    
    
    // MARK: - UserDefaults
    private func saveToUserDefaults() {
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
    
    private func setupBindings() {
        $name
            .sink { [weak self] _ in self?.saveToUserDefaults() }
            .store(in: &cancellables)
        
        $birthday
            .sink { [weak self] _ in self?.saveToUserDefaults() }
            .store(in: &cancellables)
        
        $deathDate
            .sink { [weak self] _ in self?.saveToUserDefaults() }
            .store(in: &cancellables)
        
        $age
            .sink { [weak self] _ in self?.saveToUserDefaults() }
            .store(in: &cancellables)
        
        $deathAge
            .sink { [weak self] _ in self?.saveToUserDefaults() }
            .store(in: &cancellables)
        
        $sex
            .sink { [weak self] _ in self?.saveToUserDefaults() }
            .store(in: &cancellables)
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
