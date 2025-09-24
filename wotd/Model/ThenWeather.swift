//
//  ThenWeather.swift
//  wotd
//
//  Created by EMILY on 25/03/2024.
//

import SwiftUI

struct ThenWeather: Hashable, Codable {
    let date: Date
    let city: String
    
    let min: Int
    let max: Int
    
    let morning: Int
    let afternoon: Int
    let evening: Int
    let night: Int
    
    static let empty = ThenWeather(date: Date(), city: "-", min: 1000, max: 1000, morning: 1000, afternoon: 1000, evening: 1000, night: 1000)
}
