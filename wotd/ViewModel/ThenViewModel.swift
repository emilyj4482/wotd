//
//  ThenViewModel.swift
//  wotd
//
//  Created by EMILY on 28/03/2024.
//

import Foundation

final class ThenViewModel: ObservableObject {
    
    static let shared = ThenViewModel()
    
    @Published var weathers: [ThenWeather] = [] {
        didSet {
            saveData()
        }
    }
    @Published var nowWeather: ThenWeather {
        didSet {
            print(nowWeather)
        }
    }
    
    @Published var isAddButtonHidden: Bool = false
    
    // UserDefaults 저장 key 값
    let dataKey: String = "dataKey"
    
    init(nowWeather: ThenWeather = ThenWeather(date: Date(), city: "-", min: 1000, max: 1000, morning: 1000, afternoon: 1000, evening: 1000, night: 1000)) {
        self.nowWeather = nowWeather
        getData()
    }
    
    // add
    func addWeather(_ weather: ThenWeather) {
        weathers.append(weather)
    }
    
    // delete
    func deleteWeather(_ weather: ThenWeather) {
        weathers.removeAll { $0 == weather }
    }
}

// temperature range 계산 함수
extension ThenViewModel {
    // 범위를 반환
    func getRange(then: ThenWeather, now: ThenWeather) -> (then: ClosedRange<Double>, now: ClosedRange<Double>) {
        
        let thenMin = then.min
        let thenMax = then.max
        let nowMin = now.min
        let nowMax = now.max
        
        let max = max(thenMax, nowMax)
        let min = min(thenMin, nowMin)

        // 범위가 0...max가 되도록 조정
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
        
        return lowerBound...upperBound
    }
    
    // 온도 범위 정제
    func rerangeTemp(min: Int, max: Int, temp: Int) -> Double {
        var temp = temp
        
        if min < 0 {
            temp = temp + abs(min)
        } else if min == 0 {
            
        } else {
            temp = temp - abs(min)
        }
        return Double(temp)
    }
}

// User Defaults를 이용하여 then weather array를 local에 저장, 불러오기
extension ThenViewModel {
    func saveData() {
        if let encodedData = try? JSONEncoder().encode(weathers) {
            UserDefaults.standard.set(encodedData, forKey: dataKey)
        }
    }
    
    func getData() {
        guard
            let data = UserDefaults.standard.data(forKey: dataKey),
            let savedData = try? JSONDecoder().decode([ThenWeather].self, from: data)
        else { return }
        self.weathers = savedData
    }
}
