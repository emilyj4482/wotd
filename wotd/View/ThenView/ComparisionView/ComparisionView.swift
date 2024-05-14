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
        VStack(spacing: 15) {
            ComparisionRect(weather: $weather, tempRange: vm.getRange(then: weather, now: vm.nowWeather).then, isThen: true)
            
            ComparisionRect(weather: $vm.nowWeather, tempRange: vm.getRange(then: weather, now: vm.nowWeather).now, isThen: false)
        }
        .onAppear {
            vm.isAddButtonHidden = true
        }
        .onDisappear {
            vm.isAddButtonHidden = false
        }
    }
}

#Preview {
    ComparisionView(weather: ThenWeather(date: "2023-10-20", city: "London", min: -1, max: 13, morning: -1, afternoon: 2, evening: 11, night: 13))
}
