//
//  NowViewModel.swift
//  wotd
//
//  Created by EMILY on 05/06/2024.
//

import Foundation

final class NowViewModel: ObservableObject {
    
    static let shared = NowViewModel()
    
    @Published var location: String = "-"
    
    @Published var today = NowWeather(day: "Now")
    @Published var yesterday = NowWeather(day: "Yesterday")
    @Published var tomorrow = NowWeather(day: "Tomorrow")
    
    init() {
        setDateInfo()
    }

    private func setDateInfo() {
        // 현재 시간 기준 day/night 여부를 today, yesterday, tomorrow의 프로퍼티에 전달
        let now: Date = .now
        
        [today, yesterday, tomorrow].forEach { day in
            day.isDaytime = now.isDayTime
        }
        
        // 현재 날짜 기준 오늘, 어제, 내일 날짜를 url 파라미터에 적합한 형태로 가공하여 전달
        let threedays = [now, now - 86400, now + 86400]
        var dateParams: [(dt: String, date: String)] = []
        
        threedays.forEach { day in
            dateParams.append((dt: day.dtString, date: day.dateString))
        }
        
        today.setDate(dt: dateParams[0].dt, date: dateParams[0].date)
        yesterday.setDate(dt: dateParams[1].dt, date: dateParams[1].date)
        tomorrow.setDate(dt: dateParams[2].dt, date: dateParams[2].date)
    }
}
