//
//  LocationManager.swift
//  wotd
//
//  Created by EMILY on 19/12/2023.
//

import CoreLocation

final class LocationManager: NSObject, ObservableObject {
    
    private let networkManager = NetworkManager()
    private let vm = NowViewModel.shared
    
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    private func getCityname(_ location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard error == nil, let cityName = placemarks?[0].locality else { return }
            self?.vm.location = cityName
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
            locationManager.startUpdatingLocation()
            // locationManager.stopUpdatingLocation()
        case .authorizedWhenInUse:
            print("[AUTH] When in use")
            locationManager.startUpdatingLocation()
            // locationManager.stopUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        // 1. 수집한 위치정보의 행정구역명을 view model에 전송
        getCityname(location)
        // 2. 좌표 정보를 view model에 전송
        let x = String(location.coordinate.longitude)
        let y = String(location.coordinate.latitude)
        vm.today.setCoordinates(x: x, y: y)
        vm.yesterday.setCoordinates(x: x, y: y)
        vm.tomorrow.setCoordinates(x: x, y: y)
        // 3. 위치 정보 수집 중지
        manager.stopUpdatingLocation()
        // 4. weather api 통신
        networkManager.requestWeatherInfo()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
