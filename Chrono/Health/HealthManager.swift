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
    
    @Published var heartRate: Double?
    @Published var stepCount: Double?
    @Published var activeCalories: Double?
    @Published var sleepDuration: Double?

        private init() {
            loadFromUserDefaults()
        }
    

    func isHealthKitAvailable() -> Bool {
        return HKHealthStore.isHealthDataAvailable()
    }

    func requestHealthKitPermission(completion: @escaping (Bool) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            print(#file, #line, #function, "HealthKit is not available on this device")
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
                print(#file, #line, #function, "HealthKit authorization granted")
            } else {
                print(#file, #line, #function, "HealthKit authorization failed: \(error?.localizedDescription ?? "Unknown error")")
            }
            completion(success)
        }
    }

    func fetchHeartRateData(completion: @escaping (Double?) -> Void) {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
                completion(nil)
                return
            }

            guard let startDate = calendar.date(byAdding: .year, value: -1, to: now) else {
                completion(nil)
                return
            }
            
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)
            
            let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { _, result, error in
                guard let averageQuantity = result?.averageQuantity(), error == nil else {
                    print(#file, #line, #function, "Failed to fetch annual average heart rate: \(error?.localizedDescription ?? "Unknown error")")
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

        guard let startDate = calendar.date(byAdding: .year, value: -1, to: now) else {
            completion(nil)
            return
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            guard let sumQuantity = result?.sumQuantity(), error == nil else {
                print(#file, #line, #function, "Failed to fetch annual step count: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }

            let totalStepCount = sumQuantity.doubleValue(for: HKUnit.count())

            let numberOfDays = calendar.dateComponents([.day], from: startDate, to: now).day ?? 365
            let averageDailyStepCount = totalStepCount / Double(numberOfDays)

            DispatchQueue.main.async {
                self.stepCount = averageDailyStepCount
                self.saveToUserDefaults()
            }

            completion(averageDailyStepCount)
        }

        healthStore.execute(query)
    }

    func fetchActiveCaloriesData(completion: @escaping (Double?) -> Void) {
        guard let activeEnergyType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
            completion(nil)
            return
        }

        guard let startDate = calendar.date(byAdding: .year, value: -1, to: now) else {
            completion(nil)
            return
        }

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now, options: .strictStartDate)

        let query = HKStatisticsQuery(quantityType: activeEnergyType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            guard let sumQuantity = result?.sumQuantity(), error == nil else {
                print(#file, #line, #function, "Failed to fetch annual active calories: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }

            let totalActiveCalories = sumQuantity.doubleValue(for: HKUnit.kilocalorie())

            let numberOfDays = calendar.dateComponents([.day], from: startDate, to: now).day ?? 365
            let averageDailyActiveCalories = totalActiveCalories / Double(numberOfDays)

            DispatchQueue.main.async {
                self.activeCalories = averageDailyActiveCalories
                self.saveToUserDefaults()
            }

            completion(averageDailyActiveCalories)
        }

        healthStore.execute(query)
    }
    
    func fetchSleepData(completion: @escaping (Double?) -> Void) {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            completion(nil)
            return
        }

        guard let startDate = Calendar.current.date(byAdding: .year, value: -1, to: Date()) else {
            completion(nil)
            return
        }

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)

        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { _, samples, error in
            guard let samples = samples as? [HKCategorySample], error == nil else {
                print(#file, #line, #function, "Failed to fetch sleep data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }

            var sleepDataByDate: [Date: Double] = [:]

            for sample in samples {
                let startOfSleep = Calendar.current.startOfDay(for: sample.startDate)
                let durationInMinutes = sample.endDate.timeIntervalSince(sample.startDate) / 60

                // 모든 유형의 수면 데이터 포함 (inBed 제외)
                if sample.value != HKCategoryValueSleepAnalysis.inBed.rawValue {
                    sleepDataByDate[startOfSleep, default: 0] += durationInMinutes
                }
            }

            let totalSleepMinutes = sleepDataByDate.values.reduce(0, +)
            let recordedDaysCount = sleepDataByDate.keys.count

            guard recordedDaysCount > 0 else {
                completion(nil)
                return
            }

            let averageSleepMinutes = totalSleepMinutes / Double(recordedDaysCount)

            DispatchQueue.main.async {
                self.sleepDuration = averageSleepMinutes
                self.saveToUserDefaults()
            }

            print(#file, #line, #function, "Updated average sleep duration: \(averageSleepMinutes) minutes")
            completion(averageSleepMinutes)
        }

        healthStore.execute(query)
    }
    
    func formatSleepDuration(_ minutes: Double) -> String {
        let HH = Int(minutes) / 60
        let mm = Int(minutes) % 60
        return "\(HH)H \(mm)m"
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



