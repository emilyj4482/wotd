//
//  Weather.swift
//  wotd
//
//  Created by EMILY on 04/01/2024.
//

import Foundation

struct CurrentWeather {
    var location: String
    var isDaytime: Bool
    
    var temp: Double
    var code: Int
    
    var maxTemp: Int
    var minTemp: Int
    
    var icon: String {
        // https://openweathermap.org/weather-conditions 참고 weather condition code에 따라 띄울 icon 반환
        switch code {
        case 200, 201, 202, 230, 231, 232:
            return Thunderstorm.rain.systemName
        case 210...221:
            return Thunderstorm.moderate.systemName
        case 300..<400:
            return Rain.drizzle.systemName
        case 500, 520:
            if isDaytime {
                return Rain.lightDay.systemName
            } else {
                return Rain.lightNight.systemName
            }
        case 501, 521, 531:
            return Rain.moderate.systemName
        case 502, 503, 504, 522:
            return Rain.heavy.systemName
        case 511, 611...616:
            return Snow.sleet.systemName
        case 600, 620:
            return Snow.light.systemName
        case 601, 602, 621, 622:
            return Snow.moderate.systemName
        case 701:
            return Atmosphere.mist.systemName
        case 711, 721, 741:
            return Atmosphere.fog.systemName
        case 771, 781:
            return Atmosphere.tornado.systemName
        case 731, 751, 761, 762:
            if isDaytime {
                return Atmosphere.dustDay.systemName
            } else {
                return Atmosphere.dustNight.systemName
            }
        case 801, 802:
            return Clouds.moderate.systemName
        case 803, 804:
            return Clouds.overcast.systemName
        default:
            if isDaytime {
                return Clear.day.systemName
            } else {
                return Clear.night.systemName
            }
        }
    }
    
    var currentTempAndCodeRequest = Request(
        urlComponent: "https://api.openweathermap.org/data/3.0/onecall/timemachine?",
        params: [
            "lat": "",
            "lon": "",
            "dt": "",
            "appid": "f27181cb10370ef77a1d09ab93c3fa2f",
            "units": "metric"
        ]
    )
    
    var maxAndMinTempRequest = Request(
        urlComponent: "https://api.openweathermap.org/data/3.0/onecall/day_summary?",
        params: [
            "lat": "",
            "lon": "",
            "date": "",
            "appid": "f27181cb10370ef77a1d09ab93c3fa2f",
            "units": "metric"
        ]
    )
    
    init(location: String = "", temp: Double = 0.0, code: Int = 800, isDaytime: Bool = true, maxTemp: Int = 0, minTemp: Int = 0) {
        self.location = location
        self.temp = temp
        self.code = code
        self.isDaytime = isDaytime
        self.maxTemp = maxTemp
        self.minTemp = minTemp
    }
    
    mutating func setDate(dt: String, date: String) {
        currentTempAndCodeRequest.params.updateValue(dt, forKey: "dt")
        maxAndMinTempRequest.params.updateValue(date, forKey: "date")
    }
    
    mutating func setCoordinates(x: String, y: String) {
        currentTempAndCodeRequest.params.updateValue(y, forKey: "lat")
        currentTempAndCodeRequest.params.updateValue(x, forKey: "lon")
        maxAndMinTempRequest.params.updateValue(y, forKey: "lat")
        maxAndMinTempRequest.params.updateValue(x, forKey: "lon")
    }
}
