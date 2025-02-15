//
//  CoreLocation.swift
//  Chrono
//
//  Created by ymy on 1/31/25.
//

import Foundation
import CoreLocation

class CoreLocation: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var continent: String?
    @Published var country: String?
    @Published var continentLifeExpectancy: Int?
    
    override init() {
        super.init()
        locationManager.delegate = self
        loadFromUserDefaults()
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
        fetchCountry(from: newLocation)
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
    
    func fetchContinent(from location: CLLocation) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        let determinedContinent = determineContinent(latitude: latitude, longitude: longitude)
        self.continent = determinedContinent
        self.continentLifeExpectancy = getLifeExpectancy(for: determinedContinent)
        
        saveToUserDefaults()
    }
    
    func fetchCountry(from location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }

            if let error = error {
                print(#file, #line, #function, "Failed to reverse geocode location: \(error.localizedDescription)")
                return
            }

            guard let placemark = placemarks?.first, let countryName = placemark.country else {
                print(#file, #line, #function, "No valid country found.")
                return
            }

            DispatchQueue.main.async {
                self.country = countryName
                print(#file, #line, #function, "Country successfully set: \(countryName)")
            }
        }
        
        saveToUserDefaults()
    }
    
    func determineContinent(latitude: Double, longitude: Double) -> String {
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
    
    // MARK: - UserDefaults
    func saveToUserDefaults() {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        
        guard let location = location else { return }
        
        let snapshot = LocationDataSnapshot(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            continent: self.continent ?? "Unknown",
            country: self.country ?? "Unknown",
            continentLifeExpectancy: self.continentLifeExpectancy ?? 75
        )
        
        if let encoded = try? encoder.encode(snapshot) {
            defaults.set(encoded, forKey: "LocationData")
        }
    }
    
    func loadFromUserDefaults() {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        
        if let savedData = defaults.data(forKey: "LocationData"),
           let snapshot = try? decoder.decode(LocationDataSnapshot.self, from: savedData) {
            self.location = CLLocation(latitude: snapshot.latitude, longitude: snapshot.longitude)
            self.continent = snapshot.continent
            self.continentLifeExpectancy = snapshot.continentLifeExpectancy
        }
    }
}
