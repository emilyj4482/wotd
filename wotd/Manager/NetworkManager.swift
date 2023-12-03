//
//  NetworkManager.swift
//  wotd
//
//  Created by EMILY on 01/12/2023.
//

import Foundation

// https://api.openweathermap.org/data/3.0/onecall/timemachine?lat=37.3039&lon=127.0102&dt=1701193357&appid=f27181cb10370ef77a1d09ab93c3fa2f
// https://dapi.kakao.com/v2/local/search/address.json?query=수원

class NetworkManager {

    /*
    var x: String = "127.454499829132"
    var y: String = "36.7423562993671"
    var dt: String = ""
    */
    
    // let config = URLSessionConfiguration.default
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    
    func getKakao(location: String) {
        // query를 제외한 url
        var kakaoMapUrl = URLComponents(string: "https://dapi.kakao.com/v2/local/search/address.json?")
        
        // query : query
        let kakaoQuery = URLQueryItem(name: "query", value: location)

        kakaoMapUrl?.queryItems?.append(kakaoQuery)
    
        // request URL
        guard let requestURL = kakaoMapUrl?.url else { return }
        
        // request
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        // header
        request.setValue("KakaoAK e8763e7acea6ae6cab9f86791c576fb8", forHTTPHeaderField: "Authorization")
        
        // dataTask
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard
                let statusCode = (response as? HTTPURLResponse)?.statusCode,
                let data = data
            else { return }
            
            let successRange = 200..<300
            if successRange.contains(statusCode) {
                
                /*
                guard let resultString = String(data: data, encoding: .utf8)
                else { return }
                print(resultString)
                
                */
                
                
                let decoder = JSONDecoder()
                
                // 가져 온 data를 decode
                do {
                    let locationInformation = try decoder.decode(LocationInfo.self, from: data)
                    DispatchQueue.main.async {
                        print("locationInfo >>>> \(locationInformation.location[0])")
                    }
                } catch let error {
                    print("ERROR >>> \(error)")
                }
            }
        }
        dataTask.resume()
            
            /*
             func getTask(urlString: String) {
             URLSession.shared.dataTask() {}.resume()
             }
             */
        }
    
    
    func getOpenWeather(x: String, y: String, dt: String) {
        // query를 제외한 url
        var openWeatherUrl = URLComponents(string: "https://api.openweathermap.org/data/3.0/onecall/timemachine?")
        
        // query : lat, lon, dt, appid
        let latQuery = URLQueryItem(name: "lat", value: y)
        let lonQuery = URLQueryItem(name: "lon", value: x)
        let dtQuery = URLQueryItem(name: "dt", value: dt)
        let appidQuery = URLQueryItem(name: "appid", value: "f27181cb10370ef77a1d09ab93c3fa2f")
        
        [latQuery, lonQuery, dtQuery, appidQuery]
            .forEach { openWeatherUrl?.queryItems?.append($0) }

        // request URL
        guard let requestURL = openWeatherUrl?.url else { return }
        
        // request
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        // header : 없음
        
        // dataTask
        let dataTask = session.dataTask(with: request) { [unowned self] data, response, error in
            guard
                let statusCode = (response as? HTTPURLResponse)?.statusCode,
                let data = data
            else { return }
            
            let successRange = 200..<300
            if successRange.contains(statusCode) {
                let decoder = JSONDecoder()
                
                do {
                    let weatherInformation = try decoder.decode(WeatherInfo.self, from: data)
                    DispatchQueue.main.async {
                        print("weatherInfo >>> \(weatherInformation.weather)")
                        print("오창읍 온도 >>> \(weatherInformation.weather[0].temp - 273.15)")
                        // 온도가 정확하지 않은 거 같음;;
                    }
                } catch let error {
                    print("ERROR >>> \(error)")
                }
            }
            
        }
        dataTask.resume()
    }
    
    
    
    
    }

