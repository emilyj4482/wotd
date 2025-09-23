//
//  NowViewModel.swift
//  wotd
//
//  Created by EMILY on 05/06/2024.
//

import Foundation
import CoreLocation
import Combine

final class NowViewModel: ObservableObject {
    private let locationManager = LocationManager()
    private let repository: WeatherRepositoryProtocol = WeatherRepository()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var cityName: String = "-"
    
    @Published var yesterday: NowWeather = .empty
    @Published var today: NowWeather = .empty
    @Published var tomorrow: NowWeather = .empty
    
    @Published var error: Error?
    
    init() {
        locationManager.getCityname()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error
                    print(error.errorMessage)
                case .finished:
                    print("")
                }
            } receiveValue: { [weak self] cityName in
                self?.cityName = cityName
            }
            .store(in: &cancellables)
        
        locationManager.location
            .map { [weak self] in
                self?.getParameters($0) ?? []
            }
            .flatMap { [weak self] parameters in
                guard let self else { return Empty<([WeatherCode],[DailyTemperature]), NetworkError>().eraseToAnyPublisher() }
                return Publishers.CombineLatest(
                    repository.fetchWeatherCodes(parameters: parameters),
                    repository.fetchDailyTemperatures(parameters: parameters)
                )
                .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { [weak self] weatherCodes, dailyTemperatures in
                guard
                    let weathers = self?.transform(weatherCodes: weatherCodes, dailyTemperatures: dailyTemperatures),
                    weathers.count == 3
                else { return }
                
                self?.yesterday = weathers[0]
                self?.today = weathers[1]
                self?.tomorrow = weathers[2]
            })
            .store(in: &cancellables)
    }

    private func getParameters(_ location: CLLocation) -> [CoordinateParameter] {
        let coordinate = location.coordinate
        let now: Date = .now
        
        let threedays = [now - 86400, now, now + 86400]
        
        return threedays.map {
            CoordinateParameter(latitude: coordinate.latitude, longitude: coordinate.longitude, dt: $0.timestampInteger, date: $0.dateString)
        }
    }

    private func transform(weatherCodes: [WeatherCode], dailyTemperatures: [DailyTemperature]) -> [NowWeather] {
        zip(weatherCodes, dailyTemperatures)
            .map { weatherCodes, dailyTemperature in
                NowWeather(
                    isDaytime: Date().isDayTime,
                    temp: weatherCodes.weather[0].temp,
                    maxTemp: dailyTemperature.temperature.max.toInt,
                    minTemp: dailyTemperature.temperature.min.toInt,
                    code: weatherCodes.weather[0].description[0].code
                )
            }
    }
}
