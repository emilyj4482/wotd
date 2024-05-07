//
//  ComparisionRect.swift
//  wotd
//
//  Created by EMILY on 06/04/2024.
//

import SwiftUI

struct ComparisionRect: View {
    
    // @Binding var weather: ThenWeather
    
    let weather: ThenWeather = ThenViewModel.shared.nowDummy
    let tempRange: ClosedRange<Double>
    
    @State var isThen: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.mint.opacity(0.6))
                .frame(height: 260)
                .clipShape(.rect(cornerRadius: 20))
            
            VStack {
                
                if !isThen {
                    TempProgressView(weather: weather)
                        .padding(.bottom)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(isThen ? weather.date : "Today")
                            .font(.title)
                        Text(isThen ? weather.city : "청주시")
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
                    TempProgressView(weather: weather)
                        .padding(.top)
                }
                
            }
        }
        .padding(.horizontal, 20)
    }
    
    
}

#Preview {
    // ComparisionView(weather: ThenWeather(date: "2023-10-20", city: "London", min: -1, max: 13, morning: -1, afternoon: 2, evening: 11, night: 33))
    ComparisionView(weather: ThenViewModel.shared.thenDummy)
}
