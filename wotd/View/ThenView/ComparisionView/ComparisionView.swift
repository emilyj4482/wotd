//
//  ComparisionView.swift
//  wotd
//
//  Created by EMILY on 06/04/2024.
//

import SwiftUI

struct ComparisionView: View {
    
    @State var weather: ThenWeather
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.mint)
                .frame(height: 250)
                .clipShape(.rect(cornerRadius: 20))
            
            VStack {
                /*
                TempProgressView(weather: $weather)
                    .padding(.bottom)
                */
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(weather.date)
                            .font(.title)
                        Text(weather.city)
                            .font(.title2).bold()
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 10) {
                        Text("9AM")
                        Text("12PM")
                        Text("6PM")
                        Text("12AM")
                    }
                    .monospaced()
                    .padding(.trailing, 10 )
                    
                    VStack(alignment: .trailing, spacing: 10) {
                        Text("\(weather.morning)°")
                        Text("\(weather.afternoon)°")
                        Text("\(weather.evening)°")
                        Text("\(weather.night)°")
                    }
                    .padding(.trailing, 16)
                }
                .padding(.horizontal)
                
                TempProgressView(weather: $weather)
                    .padding(.top)
                
            }
        }
        .padding(.horizontal, 20)
    }
    
    
}

#Preview {
    ComparisionView(weather: ThenWeather(date: "2023-10-20", city: "London", min: -1, max: 13, morning: -1, afternoon: 2, evening: 11, night: 13))
}
