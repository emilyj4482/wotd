//
//  SearchManager.swift
//  wotd
//
//  Created by EMILY on 18/03/2024.
//

import MapKit

final class SearchManager {
    
    /* city search */
    
    // keyword가 해당되는 행정구역명 검색
    func request(resultType: MKLocalSearch.ResultType = .pointOfInterest, searchText: String) -> [City] {
        
        var cities = [City]()
        
        let request = MKLocalSearch.Request()
        
        request.naturalLanguageQuery = searchText
        request.pointOfInterestFilter = .includingAll
        request.resultTypes = resultType
        
        let search = MKLocalSearch(request: request)
        
        search.start { response, error in
            guard let response = response else {
                print("[ERROR] \(error?.localizedDescription ?? "Unknown error occured")")
                return
            }
            cities = response.mapItems.map(City.init)
        }
        
        return cities
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
    private var request = Request.day
    
    func searchWeather(date: Date, city: City?) {
        let date = date.dateString
        // date parameter set
        request.setDate(date: date)
        
        guard let city = city else {
            print("[ERROR] no city selected")
            return
        }
        
        getCoordinate(city: city.fullName) { [weak self] coordinate, error in
            if error == nil {
                let x = String(coordinate.longitude)
                let y = String(coordinate.latitude)
                
                // 좌표 parameter set
                self?.request.setCoordinate(x: x, y: y)
                
                // api 통신 request
                self?.requestData(date: date, city: city.name, { weather in
                    print("request success")
                    // single source of truth에 추가
                    ThenViewModel.shared.addWeather(weather)
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
                    let weather = ThenWeather(date: date, city: city, min: temp.min.toInt, max: temp.max.toInt, morning: temp.morning.toInt, afternoon: temp.afternoon.toInt, evening: temp.evening.toInt, night: temp.night.toInt)
                    completionHandler(weather)
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
