//
//  ComparisionRect.swift
//  wotd
//
//  Created by EMILY on 06/04/2024.
//

import SwiftUI

struct ComparisionRect: View {
    
    @ObservedObject var vm = ThenViewModel.shared
    
    @Binding var weather: ThenWeather
    
    @State var tempRange: ClosedRange<Double>
    
    @State var isThen: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.mint.opacity(0.6))
                .frame(height: 260)
                .clipShape(.rect(cornerRadius: 20))
            
            VStack {
                
                if !isThen {
                    TempProgressView(weather: $weather, tempRange: $tempRange)
                        .padding(.bottom)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        if isThen {
                            Text(weather.date)
                                .font(.title)
                        } else {
                            Text("Today")
                                .font(.title)
                        }
                            
                        Text(isThen ? weather.city : vm.nowWeather.city)
                            .font(.title2).bold()
                    }
                    .frame(minWidth: 170, alignment: .leading)
                    
                    Spacer()
                        .frame(width: 40)
                    
                    VStack(alignment: .trailing, spacing: 10) {
                        Text("9AM")
                        Text("12PM")
                        Text("6PM")
                        Text("12AM")
                    }
                    .monospaced()
                    .padding(.leading, 5)
                    
                    VStack(alignment: .trailing, spacing: 10) {
                        Text("\(weather.morning)°")
                        Text("\(weather.afternoon)°")
                        Text("\(weather.evening)°")
                        Text("\(weather.night)°")
                    }
                    .padding(.trailing, 10)
                }
                .padding(.horizontal)
                
                if isThen {
                    TempProgressView(weather: $weather, tempRange: $tempRange)
                        .padding(.top)
                }
                
            }
        }
        .padding(.horizontal, 20)
    }
    
    
}

#Preview {
    ComparisionView(weather: ThenWeather(date: "2023-10-20", city: "London", min: -1, max: 13, morning: -1, afternoon: 2, evening: 11, night: 33))
}
