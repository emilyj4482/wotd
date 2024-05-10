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
    
    var nowDummy = ThenWeather(date: "2024-05-01", city: "청주시", min: 11, max: 18, morning: 13, afternoon: 13, evening: 17, night: 13)
    
    var thenDummy = ThenWeather(date: "2020-02-01", city: "수원시", min: -1, max: 5, morning: 0, afternoon: 3, evening: 2, night: 1)
    
    init(nowWeather: ThenWeather = ThenWeather(date: "", city: "", min: 0, max: 0, morning: 0, afternoon: 0, evening: 0, night: 0)) {
        self.nowWeather = nowDummy
    }
    
    // 최저 - 최고
    func getRange(then: ThenWeather, now: ThenWeather) -> (then: ClosedRange<Double>, now: ClosedRange<Double>) {
        
        let thenMin = then.min
        let thenMax = then.max
        let nowMin = now.min
        let nowMax = now.max
        
        
        let max = max(thenMax, nowMax)
        let min = min(thenMin, nowMin)

        let gap = getGap(max: max, min: min)
        
        let thenRange = getRange2(weather: then, gap: gap)
        let nowRange = getRange2(weather: now, gap: gap)
        
        print(thenRange)
        print(nowRange)
        
        return (thenRange, nowRange)
    }
    
    func getRange2(weather: ThenWeather, gap: Double) -> ClosedRange<Double> {
        var max = weather.max
        var min = weather.min
        
        print("max : \(max), min: \(min)")
        
        var rangeMax = getGap(max: max, min: min)
        
        let gap = Double(gap)
        
        let lowerBound = 1/gap
        let upperBound = rangeMax/gap
        
        return lowerBound...upperBound/1
    }
    
    // 일교차 범위 정제
    func getGap(max: Int, min: Int) -> Double {
        var gap = max - min
        
        if min < 0 {
            gap += abs(min)
        } else if min == 0 {
            gap += 1
        } else {
            gap = max - min + 1
        }
        return Double(gap)
    }
    
}
