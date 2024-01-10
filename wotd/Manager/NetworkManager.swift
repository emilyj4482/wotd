//
//  NetworkManager.swift
//  wotd
//
//  Created by EMILY on 04/12/2023.
//

import Foundation

// https://api.openweathermap.org/data/3.0/onecall/timemachine?lat=37.3039&lon=127.0102&dt=1701193357&appid=f27181cb10370ef77a1d09ab93c3fa2f
// https://dapi.kakao.com/v2/local/search/address.json?query=수원

final class NetworkManager: ObservableObject {
    
    static let shared = NetworkManager()
    
    @Published var today = CurrentWeather()
    @Published var yesterday = CurrentWeather()
    @Published var tomorrow = CurrentWeather()
    
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    private var addressReqeust = Request(
        urlComponent: "https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?",
        params: [
            "x": "",
            "y": ""
        ],
        header: ["Authorization": "KakaoAK e8763e7acea6ae6cab9f86791c576fb8"]
    )
    
    private var coordinateRequest = Request(
        urlComponent: "https://dapi.kakao.com/v2/local/search/address.json?",
        params: ["query": ""],
        header: ["Authorization": "KakaoAK e8763e7acea6ae6cab9f86791c576fb8"]
    )
    
    private var openWeatherDtRequest = Request(
        urlComponent: "https://api.openweathermap.org/data/3.0/onecall/timemachine?",
        params: [
            "lat": "",
            "lon": "",
            "dt": "",
            "appid": "f27181cb10370ef77a1d09ab93c3fa2f",
            "units": "metric"
        ]
    )
    
    private var openWeatherDateRequest = Request(
        urlComponent: "https://api.openweathermap.org/data/3.0/onecall/day_summary?",
        params: [
            "lat": "",
            "lon": "",
            "date": "",
            "appid": "f27181cb10370ef77a1d09ab93c3fa2f",
            "units": "metric"
        ]
    )
    
    func setDate(dt: String, date: String) {
        openWeatherDtRequest.params.updateValue(dt, forKey: "dt")
        openWeatherDateRequest.params.updateValue(date, forKey: "date")
    }
    
    func setLocation(location: String) {
        coordinateRequest.params.updateValue(location, forKey: "query")
    }
    
    func setCoordinates(x: String, y: String) {
        addressReqeust.params.updateValue(x, forKey: "x")
        addressReqeust.params.updateValue(y, forKey: "y")
        openWeatherDtRequest.params.updateValue(y, forKey: "lat")
        openWeatherDtRequest.params.updateValue(x, forKey: "lon")
        openWeatherDateRequest.params.updateValue(y, forKey: "lat")
        openWeatherDateRequest.params.updateValue(x, forKey: "lon")
        
        print(x)
        print(y)
    }
    
    func dataTask<T: Decodable>(request: URLRequest, _ type: T.Type, completionHandler: @escaping (_ information: T?, _ error: Error?) -> ()) {
        session.dataTask(with: request) { data, response, error in
            guard
                let statusCode = (response as? HTTPURLResponse)?.statusCode,
                let data = data,
                statusCode >= 200 && statusCode <= 300
            else { return }
            
            let decoder = JSONDecoder()
            do {
                let information = try decoder.decode(type, from: data)
                completionHandler(information, nil)
            } catch let error {
                print("ERROR >>> \(error)")
                completionHandler(nil, error)
            }
        }.resume()
    }
}

extension NetworkManager {
    func setToday() {
        let today: Date = .now
        
        let dt = getDtString(today)
        let date = getDateString(today)
        
        setDate(dt: dt, date: date)
        print(dt)
        print(date)
        
        self.today.isDaytime = getTime(today)
        
        print("BEFORE DATATASK")
        dataTask(request: addressReqeust.request, LocationInfo.self) { [weak self] information, error in
            DispatchQueue.main.async {
                guard let location = information?.location[0].depth2 else { return }
                print(location)
                self?.today.location = location
            }
            print(error?.localizedDescription)
        }
        
        print("AFTER DATATASK1")
        dataTask(request: openWeatherDtRequest.request, WeatherDescription.self) { [weak self] information, error in
            DispatchQueue.main.async {
                guard let weather = information?.weather[0] else { return }
                print(weather)
                self?.today.temp = weather.temp
                self?.today.code = weather.description[0].code
            }
            print(error?.localizedDescription)
        }
        print("AFTER DATATASK2")
        dataTask(request: openWeatherDateRequest.request, WeatherInfo.self) { [weak self] information, error in
            DispatchQueue.main.async {
                guard let temp = information?.temperature else { return }
                print(temp)
                self?.today.maxTemp = Int(round(temp.max))
                self?.today.minTemp = Int(round(temp.min))
            }
            print(error?.localizedDescription)
        }
        print("AFTER DATATASK3")
    }
}

extension NetworkManager {
    // 오늘 날짜를 timestamp로 변환
    func getDtString(_ date: Date) -> String {
        // Date type인 timestamp를 dt 형태로 변환
        let dt = date.timeIntervalSince1970
        // 소수점 버리고 Int로 변환
        let dtInteger = Int(floor(dt))
        
        return String(dtInteger)
    }
    
    // 오늘 날짜를 yyyy-mm-dd 형태로 변환
    func getDateString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    // 현재 시간이 day인지 night인지
    func getTime(_ date: Date) -> Bool {
        let hour = Calendar.current.component(.hour, from: date)
        
        if hour <= 6 && hour >= 18 {
            return true
        } else {
            return false
        }
    }
}
