//
//  SearchManager.swift
//  wotd
//
//  Created by EMILY on 18/03/2024.
//

import MapKit

final class SearchManager: ObservableObject {
    
    static let shared = SearchManager()
    
    @Published var cities: [City] = []
    
    func searchCities(searchText: String) {
        request(resultType: .address, searchText: searchText)
    }
    
    // keyword가 해당되는 행정구역명 검색
    private func request(resultType: MKLocalSearch.ResultType = .pointOfInterest, searchText: String) {
        let request = MKLocalSearch.Request()
        
        request.naturalLanguageQuery = searchText
        request.pointOfInterestFilter = .includingAll
        request.resultTypes = resultType
        
        let search = MKLocalSearch(request: request)
        
        search.start { [weak self] response, error in
            guard let response = response else {
                print("[ERROR] \(error?.localizedDescription ?? "Unknown error occured")")
                return
            }
            self?.cities = response.mapItems.map(City.init)
        }
    }

    // city name으로 좌표 검색
    private func getCoordinate(city: String, completionHandler: @escaping (CLLocationCoordinate2D, NSError?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { placemarks, error in
            if error == nil,
               let placemark = placemarks?[0],
               let location = placemark.location {
                completionHandler(location.coordinate, nil)
            } else {
                completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
            }
        }
    }
    
    func searchWeather(_ then: ThenWeather, date: Date, city: String) {
        // 날짜 parameter set
        then.setDate(date: date)
        getCoordinate(city: city) { coordinate, error in
            if error == nil {
                // 좌표 parameter set
                then.setCoordinate(coordinate: coordinate)
                // api 통신 request
                then.requestData()
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
