//
//  LocationManager.swift
//  wotd
//
//  Created by EMILY on 19/12/2023.
//

import CoreLocation

final class LocationManager: NSObject, ObservableObject {
    
    static let shared = LocationManager()
    private let networkManager = NetworkManager.shared
    
    @Published var location: String = "-"
    
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func getCityname(_ location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard error == nil, let cityName = placemarks?[0].locality else { return }
            self?.location = cityName
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("[AUTH] Not Determined")
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("[AUTH] Restricted")
        case .denied:
            print("[AUTH] Denied")
        case .authorizedAlways:
            print("[AUTH] Always")
            // locationManager.startUpdatingLocation()
            locationManager.stopUpdatingLocation()
        case .authorizedWhenInUse:
            print("[AUTH] When in use")
            // locationManager.startUpdatingLocation()
            locationManager.stopUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("[Location Info updated]")
        guard let location = locations.first else { return }
        getCityname(location)
        let x = String(location.coordinate.longitude)
        let y = String(location.coordinate.latitude)
        self.networkManager.setCoordinates(x: x, y: y)
        manager.stopUpdatingLocation()
        self.networkManager.requestWeatherInfo()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
