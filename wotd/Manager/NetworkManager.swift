//
//  NetworkManager.swift
//  wotd
//
//  Created by EMILY on 04/12/2023.
//

import Foundation

// https://api.openweathermap.org/data/3.0/onecall/timemachine?lat=37.3039&lon=127.0102&dt=1701193357&appid=f27181cb10370ef77a1d09ab93c3fa2f
// https://dapi.kakao.com/v2/local/search/address.json?query=수원

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    private var kakaoRequest = Request(
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
    
    func setData(location: String, dt: String, date: String) {
        kakaoRequest.params.updateValue(location, forKey: "query")
        openWeatherDtRequest.params.updateValue(dt, forKey: "dt")
        openWeatherDateRequest.params.updateValue(date, forKey: "date")
        // kakaoDataTask()
    }
    
    func setCoordinates(x: String, y: String) {
        openWeatherDtRequest.params.updateValue(y, forKey: "lat")
        openWeatherDtRequest.params.updateValue(x, forKey: "lon")
        openWeatherDateRequest.params.updateValue(y, forKey: "lat")
        openWeatherDateRequest.params.updateValue(x, forKey: "lon")
    }
    
    private func kakaoDataTask() {
        session.dataTask(with: kakaoRequest.request) { [unowned self] data, response, error in
            guard
                let statusCode = (response as? HTTPURLResponse)?.statusCode,
                let data = data
            else { return }
            
            let successRange = 200..<300
            if successRange.contains(statusCode) {
                let decoder = JSONDecoder()
                do {
                    let information = try decoder.decode(LocationInfo.self, from: data)
                    setCoordinates(x: information.location[0].x, y: information.location[0].y)
                    openWeatherDataTask()
                    openWeatherDataTask2()
                } catch let error {
                    print("ERROR >>> \(error)")
                }
            }
        }.resume()
    }
    
    private func openWeatherDataTask() {
        session.dataTask(with: openWeatherDtRequest.request) { [unowned self] data, response, error in
            guard
                let statusCode = (response as? HTTPURLResponse)?.statusCode,
                let data = data
            else { return }
            
            let successRange = 200..<300
            if successRange.contains(statusCode) {
                let decoder = JSONDecoder()
                do {
                    let information = try decoder.decode(WeatherDescription.self, from: data)
                    print(information.weather[0].description[0])
                    print(information.weather[0].temp)
                    print(formatTemp(information.weather[0].temp))
                } catch let error {
                    print("ERROR >>> \(error)")
                }
            }
        }.resume()
    }
    
    func openWeatherDataTask2() {
        session.dataTask(with: openWeatherDateRequest.request) { [unowned self] data, response, error in
            guard
                let statusCode = (response as? HTTPURLResponse)?.statusCode,
                let data = data
            else { return }
            
            let successRange = 200..<300
            if successRange.contains(statusCode) {
                let decoder = JSONDecoder()
                do {
                    let information = try decoder.decode(WeatherInfo.self, from: data)
                    print("Information >>> \(information)")
                    print("MAX >>> \(formatTemp(information.temperature.max))")
                    print("MIN >>> \(formatTemp(information.temperature.min))")
                } catch let error {
                    print("ERROR >>> \(error)")
                }
            }
        }.resume()
    }
}

extension NetworkManager {
    // 소수점 첫번째 자리까지 표시
    func formatTemp(_ temp: Double) -> String {
        return String(format: "%.1f", temp)
    }
}
