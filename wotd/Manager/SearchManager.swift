//
//  SearchManager.swift
//  wotd
//
//  Created by EMILY on 18/03/2024.
//

import MapKit

final class SearchManager: ObservableObject {
    
    static let shared = SearchManager()
    
    /* city search */
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
    
    /* weather search */
    private let vm = ThenViewModel.shared
    
    private var request = Request(
            urlComponent: "https://api.openweathermap.org/data/3.0/onecall/day_summary?",
            params: [
                "lat": "",
                "lon": "",
                "date": "",
                "appid": "f27181cb10370ef77a1d09ab93c3fa2f",
                "units": "metric"
            ]
        )
    
    func searchWeather(date: Date, city: City?) {
        let date = date.string()
        // date parameter set
        request.params.updateValue(date, forKey: "date")
        
        guard let city = city else {
            print("[ERROR] no city selected")
            return
        }
        
        getCoordinate(city: city.fullName) { [weak self] coordinate, error in
            if error == nil {
                let x = "\(coordinate.longitude)"
                let y = "\(coordinate.latitude)"
                
                // 좌표 parameter set
                self?.request.params.updateValue(x, forKey: "lon")
                self?.request.params.updateValue(y, forKey: "lat")
                
                // api 통신 request
                self?.requestData(date: date, city: city.name, { weather in
                    print("request success")
                    // single source of truth에 추가
                    self?.vm.weathers.append(weather)
                })
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func requestData(date: String, city: String, _ completionHandler: @escaping (ThenWeather) -> Void) {
        request.dataTask(WeatherInfo.self) { information, error in
            DispatchQueue.main.async {
                if let temp = information?.temperature {
                    let weather = ThenWeather(date: date, city: city, min: temp.min.int(), max: temp.max.int(), morning: temp.morning.int(), afternoon: temp.afternoon.int(), evening: temp.evening.int(), night: temp.night.int())
                    completionHandler(weather)
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
