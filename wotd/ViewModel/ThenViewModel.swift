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
    
    var nowDummy = ThenWeather(date: "2024-05-01", city: "청주시", min: 6, max: 15, morning: 13, afternoon: 13, evening: 17, night: 13)
    var thenDummy = ThenWeather(date: "2020-02-01", city: "수원시", min: 3, max: 10, morning: 0, afternoon: 3, evening: 2, night: 1)
    
    init(nowWeather: ThenWeather = ThenWeather(date: "", city: "", min: 0, max: 0, morning: 0, afternoon: 0, evening: 0, night: 0)) {
        self.nowWeather = nowDummy
    }
    
    // 범위를 반환
    func getRange(then: ThenWeather, now: ThenWeather) -> (then: ClosedRange<Double>, now: ClosedRange<Double>) {
        
        let thenMin = then.min
        let thenMax = then.max
        let nowMin = now.min
        let nowMax = now.max
        
        let max = max(thenMax, nowMax)
        let min = min(thenMin, nowMin)

        // 범위가 1...max가 되도록 조정
        let thenMinDouble = rerangeTemp(min: min, max: max, temp: thenMin)
        let thenMaxDouble = rerangeTemp(min: min, max: max, temp: thenMax)
        let nowMinDouble = rerangeTemp(min: min, max: max, temp: nowMin)
        let nowMaxDouble = rerangeTemp(min: min, max: max, temp: nowMax)
        
        let rangeMax = rerangeTemp(min: min, max: max, temp: max)
        
        // 조정된 온도값을 이용해 범위를 구하여 반환
        let thenRange = makeRange(min: thenMinDouble, max: thenMaxDouble, rangeMax: rangeMax)
        let nowRange = makeRange(min: nowMinDouble, max: nowMaxDouble, rangeMax: rangeMax)
        
        return (thenRange, nowRange)
    }
    
    // 범위를 구함
    func makeRange(min: Double, max: Double, rangeMax: Double) -> ClosedRange<Double> {
        let lowerBound = min/rangeMax
        let upperBound = max/rangeMax
        
        return lowerBound...upperBound/1
    }
    
    // 온도 범위 정제
    func rerangeTemp(min: Int, max: Int, temp: Int) -> Double {
        var temp = temp
        
        if min < 0 {
            temp = temp + abs(min) + 1
        } else if min == 0 {
            temp += 1
        } else {
            temp = temp - abs(min) + 1
        }
        return Double(temp)
    }
}
