//
//  NetworkManager.swift
//  wotd
//
//  Created by EMILY on 04/12/2023.
//

import Foundation

final class NetworkManager {
    
    private let nvm = NowViewModel.shared
    
    // openweather api 통신 요청 >>> 각 request로부터 필요한 날씨 관련 정보를 받아 published 인스턴스에 저장한다.
    private func weatherInfoDataTask(_ day: NowWeather) {
        day.currentTempAndCodeRequest.dataTask(WeatherDescription.self) { [weak self] information, error in
            DispatchQueue.main.async {
                if let weather = information?.weather[0] {
                    day.temp = weather.temp
                    day.code = weather.description[0].code
                    self?.nvm.objectWillChange.send()
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
        day.maxAndMinTempRequest.dataTask(WeatherInfo.self) { [weak self] information, error in
            DispatchQueue.main.async {
                if let temp = information?.temperature {
                    day.maxTemp = temp.max.toInt
                    day.minTemp = temp.min.toInt
                    // 수집된 현재 날씨를 then view를 위해 now weather에 저장한다
                    if day.day == "Now" {
                        ThenViewModel.shared.nowWeather = ThenWeather(date: .now, city: NowViewModel.shared.location, min: temp.min.toInt, max: temp.max.toInt, morning: temp.morning.toInt, afternoon: temp.afternoon.toInt, evening: temp.evening.toInt, night: temp.night.toInt)
                    }
                    print(day.maxTemp)
                    self?.nvm.objectWillChange.send()
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // location manager에서 모든 파라미터가 설정되었을 때 이 함수를 호출하여 weather api 통신을 한다.
    func requestWeatherInfo() {
        weatherInfoDataTask(nvm.today)
        weatherInfoDataTask(nvm.yesterday)
        weatherInfoDataTask(nvm.tomorrow)
    }
}
