//
//  WeatherViewModel.swift
//  wotd
//
//  Created by EMILY on 25/12/2023.
//

import Foundation

final class WeatherViewModel {
    func getWeatherIcon(code: Int) -> String {
        switch code {
            
        case 200..<300:
            if code == 201 {
                return ""
            } else {
                return ""
            }
        case 301:
            return ""
            
        default:
            return Clear.day.systemName
        }
    }
}
