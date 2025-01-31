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
    
    private init() {}

    func isHealthKitAvailable() -> Bool {
        return HKHealthStore.isHealthDataAvailable()
    }

    func requestHealthKitPermission(completion: @escaping (Bool) -> Void) {
        guard isHealthKitAvailable() else {
            print("HealthKit is not available on this device")
            completion(false)
            return
        }
        
        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        let readTypes: Set<HKObjectType> = [heartRateType]

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

        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: heartRateType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { _, samples, error in
            guard let sample = samples?.first as? HKQuantitySample, error == nil else {
                print("Failed to fetch heart rate samples: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            let heartRateUnit = HKUnit(from: "count/min")
            let heartRateValue = sample.quantity.doubleValue(for: heartRateUnit)
            
            DispatchQueue.main.async {
                self.heartRate = heartRateValue
            }
            
            completion(heartRateValue)
        }
        
        healthStore.execute(query)
    }
}
