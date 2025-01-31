//
//  CoreLocation.swift
//  Chrono
//
//  Created by ymy on 1/31/25.
//

import Foundation
import CoreLocation

class CoreLocation: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var continent: String?
    @Published var continentLifeExpectancy: Int?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.first else { return }
        location = newLocation
        fetchContinent(from: newLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            print(#file, #line, #function, "Falied to access location.")
        case .notDetermined:
            print(#file, #line, #function, "access not determined")
        @unknown default:
            print(#file, #line, #function, "unknown error")
        }
    }
    
    private func fetchContinent(from location: CLLocation) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        let determinedContinent = determineContinent(latitude: latitude, longitude: longitude)
        self.continent = determinedContinent
        self.continentLifeExpectancy = getLifeExpectancy(for: determinedContinent)
    }
    
    private func determineContinent(latitude: Double, longitude: Double) -> String {
        switch (latitude, longitude) {
        case (-90 ... 90, -180 ... -30):
            return "America"
        case (0 ... 90, -30 ... 60):
            return "Europe"
        case (-35 ... 35, 20 ... 150):
            return "Africa"
        case (-50 ... 10, 100 ... 180):
            return "Australia"
        case (10 ... 80, 60 ... 180):
            return "Asia"
        case (-90 ... -60, -180 ... 180):
            return "N/A"
        default:
            return "Unknown"
        }
    }
    
    private func getLifeExpectancy(for continent: String) -> Int {
           let lifeExpectancyData: [String: Int] = [
               "America": 79,
               "Europe": 81,
               "Africa": 64,
               "Australia": 83,
               "Asia": 76,
               "Antarctica": 0 // 극지방 (의미 없음)
           ]
           return lifeExpectancyData[continent] ?? 75 // 기본값: 75세
       }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
        print(#file, #line, #function, "Location updates stopped")
    }
}
