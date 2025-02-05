//
//  Health.swift
//  Chrono
//
//  Created by ymy on 1/31/25.
//

import Foundation
import HealthKit
import Combine

class HealthManager: ObservableObject {
    static let shared = HealthManager()
    
    private let healthStore = HKHealthStore()
    
    @Published var heartRate: Double? {
        didSet { saveToUserDefaults() }
    }
    @Published var stepCount: Double? {
        didSet { saveToUserDefaults() }
    }
    @Published var activeCalories: Double? {
        didSet { saveToUserDefaults() }
    }
    @Published var sleepDuration: Double? {
        didSet { saveToUserDefaults() }
    }

        private init() {
            loadFromUserDefaults()
        }
    

    func isHealthKitAvailable() -> Bool {
        return HKHealthStore.isHealthDataAvailable()
    }

    func requestHealthKitPermission(completion: @escaping (Bool) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit is not available on this device")
            completion(false)
            return
        }
        
        let readTypes: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .heartRate)!,
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        ]

        healthStore.requestAuthorization(toShare: nil, read: readTypes) { success, error in
            if success {
                print("HealthKit authorization granted")
            } else {
                print("HealthKit authorization failed: \(error?.localizedDescription ?? "Unknown error")")
            }
            completion(success)
        }
    }

    func fetchHeartRateData(completion: @escaping (Double?) -> Void) {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
                completion(nil)
                return
            }

            let calendar = Calendar.current
            let now = Date()
            guard let startDate = calendar.date(byAdding: .year, value: -1, to: now) else {
                completion(nil)
                return
            }
            
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
            
            let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { _, result, error in
                guard let averageQuantity = result?.averageQuantity(), error == nil else {
                    print("Failed to fetch annual average heart rate: \(error?.localizedDescription ?? "Unknown error")")
                    completion(nil)
                    return
                }

                let heartRateUnit = HKUnit(from: "count/min")
                let averageHeartRateValue = averageQuantity.doubleValue(for: heartRateUnit)
                
                DispatchQueue.main.async {
                    self.heartRate = averageHeartRateValue
                    self.saveToUserDefaults()
                }
                
                completion(averageHeartRateValue)
            }
            
            healthStore.execute(query)
    }
    
    func fetchStepCountData(completion: @escaping (Double?) -> Void) {
            guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
                completion(nil)
                return
            }

            let startOfDay = Calendar.current.startOfDay(for: Date())
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: Date(), options: .strictStartDate)

            let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
                guard let sum = result?.sumQuantity(), error == nil else {
                    print("Failed to fetch step count: \(error?.localizedDescription ?? "Unknown error")")
                    completion(nil)
                    return
                }

                let stepCountValue = sum.doubleValue(for: HKUnit.count())

                DispatchQueue.main.async {
                    self.stepCount = stepCountValue
                    self.saveToUserDefaults()
                }
                
                completion(stepCountValue)
            }
            
            healthStore.execute(query)
        }

        func fetchActiveCaloriesData(completion: @escaping (Double?) -> Void) {
            guard let activeEnergyType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
                completion(nil)
                return
            }

            let startOfDay = Calendar.current.startOfDay(for: Date())
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: Date(), options: .strictStartDate)

            let query = HKStatisticsQuery(quantityType: activeEnergyType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
                guard let sum = result?.sumQuantity(), error == nil else {
                    print("Failed to fetch active calories: \(error?.localizedDescription ?? "Unknown error")")
                    completion(nil)
                    return
                }

                let activeCaloriesValue = sum.doubleValue(for: HKUnit.kilocalorie())

                DispatchQueue.main.async {
                    self.activeCalories = activeCaloriesValue
                    self.saveToUserDefaults()
                }
                
                completion(activeCaloriesValue)
            }
            
            healthStore.execute(query)
        }

        func fetchSleepData(completion: @escaping (Double?) -> Void) {
            guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
                completion(nil)
                return
            }

            let startOfDay = Calendar.current.startOfDay(for: Date())
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: Date(), options: .strictStartDate)

            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)

            let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor]) { _, samples, error in
                guard let sample = samples?.first as? HKCategorySample, error == nil else {
                    print("Failed to fetch sleep data: \(error?.localizedDescription ?? "Unknown error")")
                    completion(nil)
                    return
                }

                let sleepDurationValue = sample.endDate.timeIntervalSince(sample.startDate) / 60

                DispatchQueue.main.async {
                    self.sleepDuration = sleepDurationValue
                    self.saveToUserDefaults()
                }
                
                completion(sleepDurationValue)
            }
            
            healthStore.execute(query)
        }
    
    func formatSleepDuration(_ minutes: Double) -> String {
        let hours = Int(minutes) / 60
        let remainingMinutes = Int(minutes) % 60
        return "\(hours)H \(remainingMinutes)m"
    }
    
    // MARK: - UserDefaults
    func saveToUserDefaults() {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        let snapshot = HealthDataSnapshot(
            heartRate: self.heartRate ?? 0.0,
            stepCount: self.stepCount ?? 0.0,
            activeCalories: self.activeCalories ?? 0.0,
            sleepDuration: self.sleepDuration ?? 0.0
        )
        
        if let encoded = try? encoder.encode(snapshot) {
            defaults.set(encoded, forKey: "HealthData")
        }
    }

    func loadFromUserDefaults() {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        
        if let savedData = defaults.data(forKey: "HealthData"),
           let snapshot = try? decoder.decode(HealthDataSnapshot.self, from: savedData) {
            self.heartRate = snapshot.heartRate
            self.stepCount = snapshot.stepCount
            self.activeCalories = snapshot.activeCalories
            self.sleepDuration = snapshot.sleepDuration
        }
    }
}



