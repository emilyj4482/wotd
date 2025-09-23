//
//  WeatherRepository.swift
//  wotd
//
//  Created by EMILY on 23/09/2025.
//

import Foundation
import Moya
import Combine
import CombineMoya

protocol WeatherRepositoryProtocol {
    func fetchWeatherCodes(parameters: [CoordinateParameter]) -> AnyPublisher<[WeatherCode], NetworkError>
    func fetchDailyTemperatures(parameters: [CoordinateParameter]) -> AnyPublisher<[DailyTemperature], NetworkError>
}

final class WeatherRepository: WeatherRepositoryProtocol {
    private let provider = MoyaProvider<OpenWeatherAPI>()
    
    private func fetchWeatherCode(parameter: CoordinateParameter) -> AnyPublisher<WeatherCode, NetworkError> {
        return provider.requestPublisher(.fetchWeatherCode(lat: parameter.latitude, lon: parameter.longitude, dt: parameter.dt))
            .map(\.data)
            .decode(type: WeatherCode.self, decoder: JSONDecoder())
            .mapError { error in
                switch error {
                    case let moyaError as MoyaError:
                    return NetworkError.moyaError(moyaError)
                case let decodingError as DecodingError:
                    return NetworkError.decodingError
                default:
                    return NetworkError.unknown(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func fetchDailyTemperature(parameter: CoordinateParameter) -> AnyPublisher<DailyTemperature, NetworkError> {
        return provider.requestPublisher(.fetchDailyTemperature(lat: parameter.latitude, lon: parameter.longitude, date: parameter.date))
            .map(\.data)
            .decode(type: DailyTemperature.self, decoder: JSONDecoder())
            .mapError { error in
                switch error {
                    case let moyaError as MoyaError:
                    return NetworkError.moyaError(moyaError)
                case let decodingError as DecodingError:
                    return NetworkError.decodingError
                default:
                    return NetworkError.unknown(error)
                }
            }
            .eraseToAnyPublisher()
    }
}

extension WeatherRepository {
    func fetchWeatherCodes(parameters: [CoordinateParameter]) -> AnyPublisher<[WeatherCode], NetworkError> {
        let publishers = parameters.enumerated()
            .map { index, parameter in
                fetchWeatherCode(parameter: parameter)
                    .map { (index, $0) }
            }
        
        return Publishers.MergeMany(publishers)
            .collect()
            .map { indexedResponses in
                return indexedResponses.sorted { $0.0 < $1.0 }.map { $0.1 }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchDailyTemperatures(parameters: [CoordinateParameter]) -> AnyPublisher<[DailyTemperature], NetworkError> {
        let publishers = parameters.enumerated()
            .map { index, parameter in
                fetchDailyTemperature(parameter: parameter)
                    .map { (index, $0) }
            }
        
        return Publishers.MergeMany(publishers)
            .collect()
            .map { indexedResponses in
                return indexedResponses.sorted { $0.0 < $1.0 }.map { $0.1 }
            }
            .eraseToAnyPublisher()
    }
}
