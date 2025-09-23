//
//  OpenWeatherAPI.swift
//  wotd
//
//  Created by EMILY on 06/09/2025.
//

import Foundation
import Moya

enum OpenWeatherAPI {
    case fetchWeatherCode(lat: Double, lon: Double, dt: Int)
    case fetchDailyTemperature(lat: Double, lon: Double, date: String)
}

extension OpenWeatherAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://api.openweathermap.org/data/3.0/onecall")!
    }
    
    var path: String {
        switch self {
        case .fetchWeatherCode:
            return "/timemachine?"
        case .fetchDailyTemperature:
            return "/day_summary?"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchWeatherCode(let lat, let lon, let dt):
                .requestParameters(
                    parameters: [
                        "lat": "\(lat)",
                        "lon": "\(lon)",
                        "dt": "\(dt)",
                        "appid": "f27181cb10370ef77a1d09ab93c3fa2f",
                        "units": "metric"
                    ],
                    encoding: URLEncoding.queryString)
        case .fetchDailyTemperature(let lat, let lon, let date):
                .requestParameters(
                    parameters: [
                        "lat": "\(lat)",
                        "lon": "\(lon)",
                        "date": date,
                        "appid": "f27181cb10370ef77a1d09ab93c3fa2f",
                        "units": "metric"
                    ],
                    encoding: URLEncoding.queryString
                )
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
