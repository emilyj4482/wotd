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
    
    func requestLocation() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied:
            print("[TODO] 설정에 들어가서 위치정보 수집 허용하라고 권유하기")
        default:
            break
        }
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
        // monitors permission status
        switch manager.authorizationStatus {
        case .notDetermined:
            print("[AUTH] Not Determined")
        case .restricted:
            print("[AUTH] Restricted")
        case .denied:
            print("[AUTH] Denied")
        case .authorizedAlways:
            print("[AUTH] Always")
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            print("[AUTH] When in use")
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        getCityname(location)
        let x = String(location.coordinate.longitude)
        let y = String(location.coordinate.latitude)
        self.networkManager.setCoordinates(x: x, y: y)
        manager.stopUpdatingLocation()
        // self.networkManager.requestLocation()
        self.networkManager.requestWeatherInfo()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
