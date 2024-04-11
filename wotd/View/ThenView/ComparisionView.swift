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
            
            HStack {
                VStack(alignment: .leading) {
                    Text(weather.date)
                        .font(.title)
                    Text(weather.city)
                        .font(.title2).bold()
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("9AM")
                    Text("12AM")
                    Text("6PM")
                    Text("12AM")
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(weather.morning)°")
                    Text("\(weather.afternoon)°")
                    Text("\(weather.evening)°")
                    Text("\(weather.night)°")
                }
                .padding(.trailing)
            }
            .padding(.horizontal)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ComparisionView(weather: ThenWeather(date: "2023-10-20", city: "London", min: 0, max: 0, morning: 0, afternoon: 0, evening: 0, night: 0))
}
