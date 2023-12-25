//
//  WeatherDescription.swift
//  wotd
//
//  Created by EMILY on 01/12/2023.
//

import Foundation

struct WeatherDescription: Decodable {
    let x: Double
    let y: Double
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case x = "lon"
        case y = "lat"
        case weather = "data"
    }
}

struct Weather: Decodable {
    let temp: Double
    let sunrise: Int
    let sunset: Int
    let description: [Description]
    
    enum CodingKeys: String, CodingKey {
        case temp
        case sunrise
        case sunset
        case description = "weather"
    }
}

struct Description: Decodable {
    let code: Int
    let main: String
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case code = "id"
        case main
        case detail = "description"
    }
}
