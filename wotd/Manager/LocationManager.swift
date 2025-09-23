//
//  LocationManager.swift
//  wotd
//
//  Created by EMILY on 19/12/2023.
//

import CoreLocation
import Combine

final class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    private var cancellables = Set<AnyCancellable>()
    
    private static let defaultLocation = CLLocation(latitude: 37.5665851, longitude: 126.9782038)
    
    let location = PassthroughSubject<CLLocation, Never>()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func getCityname() -> AnyPublisher<String, LocationError> {
        return Future<String, LocationError> { [weak self] promise in
            guard let self else { return }
            self.location
                .sink { completion in

                } receiveValue: { location in
                    let geocoder = CLGeocoder()
                    geocoder.reverseGeocodeLocation(location) { placemarks, error in
                        guard error == nil, let cityName = placemarks?[0].locality else { return promise(.failure(.geocoderFailed)) }
                        
                        return promise(.success(cityName))
                    }
                }
                .store(in: &self.cancellables)
        }
        .eraseToAnyPublisher()
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
            location.send(LocationManager.defaultLocation)
        case .denied:
            print("[AUTH] Denied")
            location.send(LocationManager.defaultLocation)
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
        self.location.send(location)
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("[LocationManager] \(error.localizedDescription) >>> sending default location")
        location.send(LocationManager.defaultLocation)
    }
}
