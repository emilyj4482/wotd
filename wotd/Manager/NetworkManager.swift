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
    
    private var openWeatherRequest = Request(
        urlComponent: "https://api.openweathermap.org/data/3.0/onecall/timemachine?",
        params: [
            "lat": "",
            "lon": "",
            "dt": "",
            "appid": "f27181cb10370ef77a1d09ab93c3fa2f"
        ]
    )
    
    func setData(location: String, dt: String) {
        kakaoRequest.params.updateValue(location, forKey: "query")
        openWeatherRequest.params.updateValue(dt, forKey: "dt")
        kakaoDataTask()
    }
    
    private func setCoordinates(x: String, y: String) {
        openWeatherRequest.params.updateValue(y, forKey: "lat")
        openWeatherRequest.params.updateValue(x, forKey: "lon")
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
                } catch let error {
                    print("ERROR >>> \(error)")
                }
            }
        }.resume()
    }
    
    private func openWeatherDataTask() {
        session.dataTask(with: openWeatherRequest.request) { data, response, error in
            guard
                let statusCode = (response as? HTTPURLResponse)?.statusCode,
                let data = data
            else { return }
            
            let successRange = 200..<300
            if successRange.contains(statusCode) {
                let decoder = JSONDecoder()
                do {
                    let information = try decoder.decode(WeatherInfo.self, from: data)
                    print(information.weather[0].description[0])
                    // 섭씨 온도로 변환한 뒤 반올림
                    let temp = information.weather[0].temp - 273.15
                    print("현재 날씨 >>> \(round(temp))")
                } catch let error {
                    print("ERROR >>> \(error)")
                }
            }
        }.resume()
    }
}
