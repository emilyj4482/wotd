//
//  ThenViewModel.swift
//  wotd
//
//  Created by EMILY on 28/03/2024.
//

import Foundation

final class ThenViewModel: ObservableObject {
    
    static let shared = ThenViewModel()
    
    @Published var weathers: [ThenWeather] = []
    
    @Published var isAddButtonHidden: Bool = false
    
    @Published var nowWeather: ThenWeather {
        didSet {
            print(nowWeather)
        }
    }
    
    let nowDummy = ThenWeather(date: "2024-05-01", city: "청주시", min: 11, max: 18, morning: 13, afternoon: 13, evening: 17, night: 13)
    
    let thenDummy = ThenWeather(date: "2020-02-01", city: "수원시", min: -1, max: 5, morning: 0, afternoon: 3, evening: 2, night: 1)
    
    init(nowWeather: ThenWeather = ThenWeather(date: "", city: "", min: 0, max: 0, morning: 0, afternoon: 0, evening: 0, night: 0)) {
        self.nowWeather = nowDummy
    }
    
    // 최저 - 최고
    func getRange(then: ThenWeather, now: ThenWeather) -> (then: ClosedRange<Double>, now: ClosedRange<Double>) {
        
        var thenMin = then.min
        var thenMax = then.max
        var nowMin = now.min
        var nowMax = now.max
        
        
        let max = max(thenMax, nowMax)
        let min = min(thenMin, nowMin)
        
        // 이부분도 반복이므로 함수화.
        var gap = max - min + 1
        
        if min < 0 {
            gap += abs(min)
        }
        
        let thenRange = getRange2(weather: then, gap: gap)
        let nowRange = getRange2(weather: now, gap: gap)
        
        return (thenRange, nowRange)
    }
    
    func getRange2(weather: ThenWeather, gap: Int) -> ClosedRange<Double> {
        var max = Double(weather.max)
        var min = Double(weather.min)
        
        var rangeMax = max - min + 1
        
        if min < 0 {
            rangeMax += abs(min)
        }
        
        let gap = Double(gap)
        
        return 1/gap...rangeMax/gap/1
    }
    
}
