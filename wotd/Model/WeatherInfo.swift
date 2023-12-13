//
//  WeatherInfo.swift
//  wotd
//
//  Created by EMILY on 13/12/2023.
//

import Foundation

struct WeatherInfo: Decodable {
    let x: Double
    let y: Double
    let date: String
    let temperature: Temperature
    
    enum CodingKeys: String, CodingKey {
        case x = "lon"
        case y = "lat"
        case date
        case temperature
    }
}

struct Temperature: Decodable {
    let min: Double
    let max: Double
    
    let night: Double       // 00:00
    let morning: Double     // 06:00
    let afternoon: Double   // 12:00
    let evening: Double     // 18:00
}
