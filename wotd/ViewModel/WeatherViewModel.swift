//
//  WeatherViewModel.swift
//  wotd
//
//  Created by EMILY on 25/12/2023.
//

import Foundation

final class WeatherViewModel {
    
    // https://openweathermap.org/weather-conditions 참고 weather condition code에 따라 띄울 icon 반환
    func getWeatherIcon(code: Int) -> String {
        switch code {
        case 200, 201, 202, 230, 231, 232:
            return Thunderstorm.rain.systemName
        case 210...221:
            return Thunderstorm.moderate.systemName
        case 300..<400:
            return Rain.drizzle.systemName
        case 500, 520:    // >> light rain. time 분기 필요
            if code == 500 {
                return ""
            } else {
                return ""
            }
        case 501, 521, 531:
            return Rain.moderate.systemName
        case 502, 503, 504, 522:
            return Rain.heavy.systemName
            // 511 : freezing rain : sleet
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
        case 731, 751, 761, 762: // >> time 분기 필요
            return ""
            // 80x : Clouds
        case 801, 802:
            return Clouds.moderate.systemName
        case 803, 804:
            return Clouds.overcast.systemName
            // 800 : Clear >> time 분기 필요
        default:
            return Clear.day.systemName
        }
    }
}
