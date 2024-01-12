//
//  NetworkManager.swift
//  wotd
//
//  Created by EMILY on 04/12/2023.
//

import Foundation

// https://api.openweathermap.org/data/3.0/onecall/timemachine?lat=37.3039&lon=127.0102&dt=1701193357&appid=f27181cb10370ef77a1d09ab93c3fa2f
// https://dapi.kakao.com/v2/local/search/address.json?query=수원

final class NetworkManager: ObservableObject {
    
    static let shared = NetworkManager()
    
    @Published var today = CurrentWeather()
    @Published var yesterday = CurrentWeather()
    @Published var tomorrow = CurrentWeather()
    
    // x, y 좌표 >>> 행정구역명
    private var addressReqeust = Request(
        urlComponent: "https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?",
        params: [
            "x": "",
            "y": ""
        ],
        header: ["Authorization": "KakaoAK e8763e7acea6ae6cab9f86791c576fb8"]
    )
    
    // 장소명 >>> x, y 좌표
    private var coordinateRequest = Request(
        urlComponent: "https://dapi.kakao.com/v2/local/search/address.json?",
        params: ["query": ""],
        header: ["Authorization": "KakaoAK e8763e7acea6ae6cab9f86791c576fb8"]
    )
    
    // x, y 좌표 및 timestamp >>> 현재 온도 및 날씨 코드
    private var currentTempAndCodeRequest = Request(
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
    private var maxAndMinTempRequest = Request(
        urlComponent: "https://api.openweathermap.org/data/3.0/onecall/day_summary?",
        params: [
            "lat": "",
            "lon": "",
            "date": "",
            "appid": "f27181cb10370ef77a1d09ab93c3fa2f",
            "units": "metric"
        ]
    )
    
    func setLocation(location: String) {
        coordinateRequest.params.updateValue(location, forKey: "query")
    }
    
    func setCoordinates(x: String, y: String) {
        addressReqeust.params.updateValue(x, forKey: "x")
        addressReqeust.params.updateValue(y, forKey: "y")
        today.setCoordinates(x: x, y: y)
        yesterday.setCoordinates(x: x, y: y)
        tomorrow.setCoordinates(x: x, y: y)
    }
}

extension NetworkManager {
    // 현재 날짜와 시간 인스턴스 생성 > 현재 시간 기준 day time 여부를 published 변수에 전달, 현재 날짜 기준 오늘, 어제, 내일 날짜를 url 파라미터에 적합한 형태로 가공하여 전달.
    func setDateInfo() {
        let now: Date = .now
        
        today.isDaytime = getTime(now)
        yesterday.isDaytime = getTime(now)
        tomorrow.isDaytime = getTime(now)
        
        // 순서대로 오늘, 어제, 내일
        let threedays = [now, now - 86400, now + 86400]
        
        print(threedays)
        
        var dateParams: [(dt: String, date: String)] = []
        
        threedays.forEach { day in
            dateParams.append((dt: getDtString(day), date: getDateString(day)))
        }
        
        print(dateParams)
        
        today.setDate(dt: dateParams[0].dt, date: dateParams[0].date)
        yesterday.setDate(dt: dateParams[1].dt, date: dateParams[1].date)
        tomorrow.setDate(dt: dateParams[2].dt, date: dateParams[2].date)
    }
    
    // location manager에서 수집된 x, y 좌표가 request 파라미터에 저장된 뒤 행정구역명을 수집하기 위한 kakao api data 통신을 요청하고 받은 정보를 published 변수에 저장한다.
    func requestLocation() {
        addressReqeust.dataTask(LocationInfo.self) { [weak self] information, error in
            DispatchQueue.main.async {
                if let location = information?.location[0].depth2 {
                    self?.today.location = location
                }
            }
        }
    }
    
    // 날짜와 시간 정보가 request 파라미터에 저장된 뒤 날씨 정보를 수집하기 위한 openwheather api data 통신을 요청하고 받은 정보를 published 변수에 저장한다.
    func requestWeatherInformation() {
        currentTempAndCodeRequest.dataTask(WeatherDescription.self) { [weak self] information, error in
            DispatchQueue.main.async {
                if let weather = information?.weather[0] {
                    self?.today.temp = weather.temp
                    self?.today.code = weather.description[0].code
                }
            }
        }
        
        maxAndMinTempRequest.dataTask(WeatherInfo.self) { [weak self] information, error in
            DispatchQueue.main.async {
                if let temp = information?.temperature {
                    self?.today.maxTemp = Int(temp.max)
                    self?.today.minTemp = Int(temp.min)
                }
            }
        }
    }
}

extension NetworkManager {
    // 오늘 날짜를 timestamp로 변환
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
    
    // 현재 시간이 day인지 night인지
    func getTime(_ date: Date) -> Bool {
        let hour = Calendar.current.component(.hour, from: date)
        
        if hour >= 6 && hour <= 17 {
            return true
        } else {
            return false
        }
    }
}
