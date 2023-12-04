//
//  NetworkManager.swift
//  wotd
//
//  Created by EMILY on 04/12/2023.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    func request(urlComponent: String, queries: [URLQueryItem], headerKey: String?, headerValue: String?, isLocationInfo: Bool) {
        // query를 제외한 url
        var url = URLComponents(string: urlComponent)
        
        // query
        queries.forEach { query in
            url?.queryItems?.append(query)
        }
        
        // request URL
        guard let requestURL = url?.url else { return }
        
        // request
        var request = URLRequest(url: requestURL)
        
        // request method
        request.httpMethod = "GET"
        
        // header
        if headerKey != nil && headerValue != nil {
            request.setValue(headerValue, forHTTPHeaderField: headerKey ?? "")
        }
        
        // dataTask
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard
                let statusCode = (response as? HTTPURLResponse)?.statusCode,
                let data = data
            else { return }
            
            let successRange = 200..<300
            if successRange.contains(statusCode) {
                let decoder = JSONDecoder()
                // 가져 온 data를 decode
                do {
                    if isLocationInfo {
                        let information = try decoder.decode(LocationInfo.self, from: data)
                        print(information.location[0].address)
                    } else {
                        let information = try decoder.decode(WeatherInfo.self, from: data)
                        print(information.weather[0].temp - 273.15)
                    }
                } catch let error {
                    print("ERROR >>> \(error)")
                }
            }
        }

        // dataTask 실행
        dataTask.resume()
    }
}
