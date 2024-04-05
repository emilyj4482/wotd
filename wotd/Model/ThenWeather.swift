//
//  ThenWeather.swift
//  wotd
//
//  Created by EMILY on 25/03/2024.
//

import CoreLocation

struct ThenWeather: Hashable {
    var date: String
    var city: String
    
    var min: Int
    var max: Int
    
    var morning: Int
    var afternoon: Int
    var evening: Int
    var night: Int
}
