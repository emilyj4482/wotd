//
//  CurrentWeather.swift
//  wotd
//
//  Created by EMILY on 04/01/2024.
//

import Foundation
import SwiftUI

class CurrentWeather {
    var day: String
    var isDaytime: Bool
    
    var temp: Double
    var formattedTemp: String {
        if temp == 1000.0 {
            return "-"
        } else {
            return "\(String(format: "%.1f", temp))°"
        }
    }
    
    var maxTemp: Int
    var formattedMaxTemp: String {
        if maxTemp == 1000 {
            return "-"
        } else {
            return "\(maxTemp)°"
        }
    }
    
    var minTemp: Int
    var formattedMinTemp: String {
        if minTemp == 1000 {
            return "-"
        } else {
            return "\(minTemp)°"
        }
    }
    
    var code: Int
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
    
    var colors: [Color] {
        switch code {
        case 200..<600:
            return [
                Color(uiColor: #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1))
            ]
        case 701..<800, 801..<900:
            return [
                Color(uiColor: #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)),
                Color(uiColor: #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1))
            ]
            
        // TODO: Snow
            
        default:
            if isDaytime {
                return [
                    Color(uiColor: #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)),
                    Color(uiColor: #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)),
                    Color(uiColor: #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1))
                ]
            } else {
                return [
                    Color(uiColor: #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)),
                    Color(uiColor: #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)),
                    Color(uiColor: #colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1))
                ]
            }
        }
    }
    
    // x, y 좌표 및 timestamp >>> 그 시각 온도 및 날씨 코드
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
    
    // x, y 좌표 및 날짜 >>> 최고, 최저 온도
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
    
    // data를 전송 받지 못했을 경우 formatted String을 통해 view에 -로 출력하기 위해 기본값을 1000도로 설정
    init(day: String, temp: Double = 1000.0, code: Int = 800, isDaytime: Bool = true, maxTemp: Int = 1000, minTemp: Int = 1000) {
        self.day = day
        self.temp = temp
        self.code = code
        self.isDaytime = isDaytime
        self.maxTemp = maxTemp
        self.minTemp = minTemp
    }
    
    func setDate(dt: String, date: String) {
        currentTempAndCodeRequest.params.updateValue(dt, forKey: "dt")
        maxAndMinTempRequest.params.updateValue(date, forKey: "date")
    }
    
    func setCoordinates(x: String, y: String) {
        currentTempAndCodeRequest.params.updateValue(y, forKey: "lat")
        currentTempAndCodeRequest.params.updateValue(x, forKey: "lon")
        maxAndMinTempRequest.params.updateValue(y, forKey: "lat")
        maxAndMinTempRequest.params.updateValue(x, forKey: "lon")
    }
}
