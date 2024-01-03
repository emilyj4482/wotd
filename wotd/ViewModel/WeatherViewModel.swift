//
//  WeatherViewModel.swift
//  wotd
//
//  Created by EMILY on 25/12/2023.
//

import Foundation

final class WeatherViewModel: ObservableObject {
    
    static let shared = WeatherViewModel()
    
    @Published var today = CurrentWeather()
    @Published var yesterday = CurrentWeather()
    @Published var tomorrow = CurrentWeather()

}
