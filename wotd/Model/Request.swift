//
//  Request.swift
//  wotd
//
//  Created by EMILY on 11/12/2023.
//

import Foundation

struct Request {
    let urlComponent: String
    var params: [String: String]
    let header: [String: String]
    
    var queries: [URLQueryItem] {
        params.map { key, value in
            return URLQueryItem(name: key, value: value)
        }
    }
    
    var request: URLRequest {
        
        var url = URLComponents(string: urlComponent)!
        url.queryItems = queries
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"

        header.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }
    
    init(urlComponent: String, params: [String : String], header: [String : String] = [:]) {
        self.urlComponent = urlComponent
        self.params = params
        self.header = header
    }
    
    mutating func dataTask<T: Decodable>(_ type: T.Type, completionHandler: @escaping (_ information: T?, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let statusCode = (response as? HTTPURLResponse)?.statusCode,
                let data = data
            else { return }
            
            let decoder = JSONDecoder()
            var errorMessage = ""
            
            if statusCode >= 200 && statusCode <= 300 {
                do {
                    let information = try decoder.decode(type, from: data)
                    completionHandler(information, nil)
                } catch let error {
                    print("[ERROR] \(error.localizedDescription)")
                    completionHandler(nil, error)
                }
            } else {
                // error response 형태에 따라 decode try 후 nil 아닌 것 할당
                let message = try? decoder.decode(ErrorMessage.self, from: data)
                let msg = try? decoder.decode(ErrorMessage2.self, from: data)
                errorMessage = message?.message ?? msg?.msg ?? "Unknown"
                print("[ERROR] \(errorMessage)")
            }
        }.resume()
    }
    
    static var moment = Request(
        urlComponent: "https://api.openweathermap.org/data/3.0/onecall/timemachine?",
        params: [
            "lat": "",
            "lon": "",
            "dt": "",
            "appid": "f27181cb10370ef77a1d09ab93c3fa2f",
            "units": "metric"
        ]
    )
    
    static var day = Request(
        urlComponent: "https://api.openweathermap.org/data/3.0/onecall/day_summary?",
        params: [
            "lat": "",
            "lon": "",
            "date": "",
            "appid": "f27181cb10370ef77a1d09ab93c3fa2f",
            "units": "metric"
        ]
    )
}
