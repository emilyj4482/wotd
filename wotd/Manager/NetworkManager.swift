//
//  NetworkManager.swift
//  wotd
//
//  Created by EMILY on 01/12/2023.
//

import Foundation

// https://api.openweathermap.org/data/3.0/onecall/timemachine?lat=37.3039&lon=127.0102&dt=1701193357&appid=f27181cb10370ef77a1d09ab93c3fa2f
// https://dapi.kakao.com/v2/local/search/address.json?query=수원

struct NetworkManager {
    
    
    // query를 제외한 url
    var openWeatherUrl = URLComponents(string: "https://api.openweathermap.org/data/3.0/onecall/timemachine?")
    
    /* value */
    
    
    // query : lat, lon, dt, appid
    // var latQuery = URLQueryItem(name: "lat", value: <#T##String?#>)
   
    
    
    
    let config = URLSessionConfiguration.default
    
    func getKakao() {
        // query를 제외한 url
        var kakaoMapUrl = URLComponents(string: "https://dapi.kakao.com/v2/local/search/address.json?")
        
        // query : query
        var kakaoQuery = URLQueryItem(name: "query", value: "청주시 오창읍")
        
        kakaoMapUrl?.queryItems?.append(kakaoQuery)
        
        let session = URLSession(configuration: config)
        
        
        // request URL
        guard let requestURL = kakaoMapUrl?.url else { return }

        // request
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        // header
        request.setValue("KakaoAK e8763e7acea6ae6cab9f86791c576fb8", forHTTPHeaderField: "Authorization")
        
        // dataTask
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            let successRange = 200..<300
            guard successRange.contains(statusCode) else { return }
            
            guard let resultData = data else { return }
            
            // 가져 온 data를 print
            guard let resultString = String(data: resultData, encoding: .utf8) else { return }
            
            print(resultString)
        }
        
        dataTask.resume()
        
        /*
         func getTask(urlString: String) {
         URLSession.shared.dataTask() {}.resume()
         }
         */
    }
}

