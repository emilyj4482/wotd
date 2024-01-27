//
//  NetworkManager.swift
//  wotd
//
//  Created by EMILY on 04/12/2023.
//

import Foundation

final class NetworkManager: ObservableObject {
    
    static let shared = NetworkManager()
    
    @Published var location: String = "-"
    
    @Published var today = CurrentWeather(day: "Today")
    @Published var yesterday = CurrentWeather(day: "Yesterday")
    @Published var tomorrow = CurrentWeather(day: "Tomorrow")
    
    // x, y 좌표 >>> 행정구역명
    private var addressReqeust = Request(
        urlComponent: "https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?",
        params: [
            "x": "",
            "y": ""
        ],
        header: ["Authorization": "KakaoAK e8763e7acea6ae6cab9f86791c576fb8"]
    )
    
    /* 장소명 >>> x, y 좌표
    private var coordinateRequest = Request(
        urlComponent: "https://dapi.kakao.com/v2/local/search/address.json?",
        params: ["query": ""],
        header: ["Authorization": "KakaoAK e8763e7acea6ae6cab9f86791c576fb8"]
    )
    
    func setLocation(location: String) {
        coordinateRequest.params.updateValue(location, forKey: "query")
    } */
    
    // location manager에서 이 함수를 호출하여 수집한 위치정보의 x, y 좌표값을 request url의 파라미터로 전달한다.
    func setCoordinates(x: String, y: String) {
        addressReqeust.params.updateValue(x, forKey: "x")
        addressReqeust.params.updateValue(y, forKey: "y")
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
            day.isDaytime = getTime(now)
        }
        
        // 순서대로 오늘, 어제, 내일
        let threedays = [now, now - 86400, now + 86400]
        var dateParams: [(dt: String, date: String)] = []
        
        threedays.forEach { day in
            dateParams.append((dt: getDtString(day), date: getDateString(day)))
        }
        
        today.setDate(dt: dateParams[0].dt, date: dateParams[0].date)
        yesterday.setDate(dt: dateParams[1].dt, date: dateParams[1].date)
        tomorrow.setDate(dt: dateParams[2].dt, date: dateParams[2].date)
    }
    
    // kakao api 통신 요청 >>> 행정구역명을 받아 view에 출력할 수 있도록 published 변수에 저장한다.
    func requestLocation() {
        addressReqeust.dataTask(LocationInfo.self) { [weak self] information, error in
            DispatchQueue.main.async {
                if let location = information?.location[0].depth2 {
                    self?.location = location
                }
            }
        }
    }
    
    // openweather api 통신 요청 >>> 각 request로부터 필요한 날씨 관련 정보를 받아 published 인스턴스에 저장한다.
    private func weatherInfoDataTask(_ day: CurrentWeather) {
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
                    day.maxTemp = Int(round(temp.max))
                    day.minTemp = Int(round(temp.min))
                    self?.objectWillChange.send()
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func requestWeatherInfo() {
        weatherInfoDataTask(today)
        weatherInfoDataTask(yesterday)
        weatherInfoDataTask(tomorrow)
    }
}

private extension NetworkManager {
    // 오늘 날짜 + 현재 시각을 timestamp로 변환
    func getDtString(_ date: Date) -> String {
        // Date type인 timestamp를 dt 형태로 변환
        let dt = date.timeIntervalSince1970
        // 소수점 버리고 Int로 변환
        let dtInteger = Int(floor(dt))
        
        return String(dtInteger)
    }
    
    // 오늘 날짜를 yyyy-mm-dd 형태로 변환
    func getDateString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    // 현재 시간이 day인지 night인지 구분하여 day면 true night이면 false 반환
    func getTime(_ date: Date) -> Bool {
        let hour = Calendar.current.component(.hour, from: date)
        
        if hour >= 6 && hour <= 17 {
            return true
        } else {
            return false
        }
    }
}
