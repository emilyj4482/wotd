//
//  ComparisionView.swift
//  wotd
//
//  Created by EMILY on 23/04/2024.
//

import SwiftUI

struct ComparisionView: View {
    
    @State var weather: ThenWeather
    
    @ObservedObject var vm = ThenViewModel.shared
    
    var body: some View {
        VStack {
            var diff: Int {
                let maxDiff = abs(weather.max - vm.nowWeather.max)
                if maxDiff != 0 {
                    return maxDiff
                } else {
                    return abs(weather.min - vm.nowWeather.min)
                }
            }
            
            var text: LocalizedStringResource {
                vm.nowWeather.max > weather.max ? "warmer" : "cooler"
            }
            

                Text(
                    diff == 0 ? "Today is as warm or cool as\n\(weather.city) in \(weather.date.dateString2)."
                    : "Today is \(diff)° \(text) than\n\(weather.city) in \(weather.date.dateString2)."
                )
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 25)
            
            ComparisionRect(weather: $weather, tempRange: vm.getRange(then: weather, now: vm.nowWeather).then, isThen: true)
            
            ComparisionRect(weather: $vm.nowWeather, tempRange: vm.getRange(then: weather, now: vm.nowWeather).now, isThen: false)
        }
        .offset(y: -30)
        .onAppear {
            vm.isAddButtonHidden = true
        }
        .onDisappear {
            vm.isAddButtonHidden = false
        }
    }
}

#Preview {
    ComparisionView(weather: ThenWeather(date: Date(), city: "London", min: -1, max: 13, morning: -1, afternoon: 2, evening: 11, night: 13))
}
