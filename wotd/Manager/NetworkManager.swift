//
//  NetworkManager.swift
//  wotd
//
//  Created by EMILY on 04/12/2023.
//

import Foundation

final class NetworkManager: ObservableObject {
    
    static let shared = NetworkManager()
    
    @Published var today = NowWeather(day: "Now")
    @Published var yesterday = NowWeather(day: "Yesterday")
    @Published var tomorrow = NowWeather(day: "Tomorrow")
    
    // location manager에서 이 함수를 호출하여 수집한 위치정보의 x, y 좌표값을 request url의 파라미터로 전달한다.
    func setCoordinates(x: String, y: String) {
        today.setCoordinates(x: x, y: y)
        yesterday.setCoordinates(x: x, y: y)
        tomorrow.setCoordinates(x: x, y: y)
    }
}

extension NetworkManager {
    // 현재 날짜와 시간 인스턴스 생성 > 현재 시간 기준 day/night 여부를 today, yesterday, tomorrow의 프로퍼티에 전달하고 현재 날짜 기준 오늘, 어제, 내일 날짜를 url 파라미터에 적합한 형태로 가공하여 전달.
    func setDateInfo() {
        let now: Date = .now
        
        [today, yesterday, tomorrow].forEach { day in
            day.isDaytime = now.isDayTime()
        }
        
        // 순서대로 오늘, 어제, 내일
        let threedays = [now, now - 86400, now + 86400]
        var dateParams: [(dt: String, date: String)] = []
        
        threedays.forEach { day in
            dateParams.append((dt: day.dtString(), date: day.string()))
        }
        
        today.setDate(dt: dateParams[0].dt, date: dateParams[0].date)
        yesterday.setDate(dt: dateParams[1].dt, date: dateParams[1].date)
        tomorrow.setDate(dt: dateParams[2].dt, date: dateParams[2].date)
    }
    
    // openweather api 통신 요청 >>> 각 request로부터 필요한 날씨 관련 정보를 받아 published 인스턴스에 저장한다.
    private func weatherInfoDataTask(_ day: NowWeather) {
        day.currentTempAndCodeRequest.dataTask(WeatherDescription.self) { [weak self] information, error in
            DispatchQueue.main.async {
                if let weather = information?.weather[0] {
                    day.temp = weather.temp
                    day.code = weather.description[0].code
                    self?.objectWillChange.send()
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
                    // now weather
                    if day.day == "Now" {
                        ThenViewModel.shared.nowWeather = ThenWeather(date: day.maxAndMinTempRequest.params["date"]!, city: LocationManager.shared.location, min: temp.min.toInt, max: temp.max.toInt, morning: temp.morning.toInt, afternoon: temp.afternoon.toInt, evening: temp.evening.toInt, night: temp.night.toInt)
                    }
                    self?.objectWillChange.send()
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // location manager에서 모든 파라미터가 설정되었을 때 이 함수를 호출하여 weather api 통신을 한다.
    func requestWeatherInfo() {
        weatherInfoDataTask(today)
        weatherInfoDataTask(yesterday)
        weatherInfoDataTask(tomorrow)
    }
}
