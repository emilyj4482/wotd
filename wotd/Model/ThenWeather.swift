//
//  ThenWeather.swift
//  wotd
//
//  Created by EMILY on 25/03/2024.
//

import Foundation

struct ThenWeather {
    var date: String
    var city: String
    
    var x: String
    var y: String
    
    var min: Int
    var max: Int
    
    var morning: Int
    var afternoon: Int
    var evening: Int
    var night: Int
    
    var request: Request {
        Request(
            urlComponent: "https://api.openweathermap.org/data/3.0/onecall/day_summary?",
            params: [
                "lat": y,
                "lon": x,
                "date": date,
                "appid": "f27181cb10370ef77a1d09ab93c3fa2f",
                "units": "metric"
            ]
        )
    }
    
}
