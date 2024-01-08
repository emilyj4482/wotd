//
//  WeatherViewModel.swift
//  wotd
//
//  Created by EMILY on 25/12/2023.
//

import Foundation

final class WeatherViewModel: ObservableObject {
    
    static let shared = WeatherViewModel()
    private let networkManager = NetworkManager.shared
    
    @Published var today = CurrentWeather()
    @Published var yesterday = CurrentWeather()
    @Published var tomorrow = CurrentWeather()

    // app 실행
    // 1. location manager로 위치 인식 \\ 동시에 날짜 인식
    // 2. x, y set                  \\ 동시에 날짜 set
    // 3. kakao api로 행정지역명 가져오기 >> view set
    // 3. open wheather api로 날짜 가져오기 >> view set
    
    // TODO: NetworkManager와 viewmodel 합치기
    
    // 날짜 set
    func setDate() {
        let today: Date = .now
        
        let dt = getDtString(today)
        let date = getDateString(today)
        
        networkManager.setDate(dt: dt, date: date)
    }
}

extension WeatherViewModel {
    func getDtString(_ timeStamp: Date) -> String {
        // Date type인 timestamp를 dt 형태로 변환
        let dt = timeStamp.timeIntervalSince1970
        // 소수점 버리고 Int로 변환
        let dtInteger = Int(floor(dt))
        
        return String(dtInteger)
    }
    
    func getDateString(_ timeStamp: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.string(from: timeStamp)
        return date
    }
}
