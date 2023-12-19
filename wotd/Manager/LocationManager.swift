//
//  LocationManager.swift
//  wotd
//
//  Created by EMILY on 19/12/2023.
//

import CoreLocation

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let networkManager = NetworkManager.shared
    
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAllowOnceLocationPermission() {
        // one-time delivery of the user's current location
        locationManager.requestLocation()
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
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
