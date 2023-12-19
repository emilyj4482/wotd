//
//  LocationManager.swift
//  wotd
//
//  Created by EMILY on 19/12/2023.
//

import CoreLocation

final class LocationManager: NSObject, ObservableObject {
    
    let locationManager = CLLocationManager()
    let networkManager = NetworkManager.shared
    
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func requestLocation() {
        // one-time delivery of the user's current location
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // monitors permission status
        switch manager.authorizationStatus {
            
        case .notDetermined:
            print("DEBUG: Not Determined")
        case .restricted:
            print("DEBUG: Restricted")
        case .denied:
            print("DEBUG: Denied")
        case .authorizedAlways:
            print("DEBUG: Auth Always")
        case .authorizedWhenInUse:
            print("DEBUG: Auth When in use")
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {
            // show an error
            return
        }

        DispatchQueue.main.async {
            let x = String(latestLocation.coordinate.longitude)
            let y = String(latestLocation.coordinate.latitude)
            
            self.networkManager.setCoordinates(x: x, y: y)
            self.networkManager.openWeatherDataTask2()
            manager.stopUpdatingLocation()
        }
         
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
