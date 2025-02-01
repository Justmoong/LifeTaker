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
    
    func requestLocationPermission() {
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                print(#file, #line, #function, "Location permission requested: not determined")
            case .restricted, .denied:
                print(#file, #line, #function, "Location access denied or restricted. Please update your settings.")
            case .authorizedWhenInUse, .authorizedAlways:
                print(#file, #line, #function, "Location access already granted.")
                locationManager.startUpdatingLocation()
            @unknown default:
                print(#file, #line, #function, "Unknown authorization status encountered.")
            }
        } else {
            print(#file, #line, #function, "Location services are disabled.")
        }
    }
    
    func updateLocation() {
        locationManager.requestLocation()
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
    
    func getLifeExpectancy(for continent: String) -> Int {
           let lifeExpectancyData: [String: Int] = [
               "America": 76,
               "Europe": 78,
               "Africa": 62,
               "Australia": 80,
               "Asia": 73,
               "Antarctica": 0 // 극지방 (의미 없음)
           ]
           return lifeExpectancyData[continent] ?? 75
       }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
        print(#file, #line, #function, "Location updates stopped")
    }
}
