//
//  WeatherVStack.swift
//  wotd
//
//  Created by EMILY on 06/04/2024.
//

import SwiftUI

struct WeatherVStack: View {
    
    @State var weathers: [ThenWeather] = [
        ThenWeather(date: "2024-01-01", city: "Brighton", min: 1, max: 10, morning: 3, afternoon: 5, evening: 10, night: 1)
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(weathers, id: \.self) { weather in
                    NavigationLink(value: weather) {
                        VStack(alignment: .leading) {
                            Text(weather.date)
                                .font(.title3).bold()
                            Text(weather.city)
                                .font(.title)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Weathers to compare")
            .navigationDestination(for: ThenWeather.self) { weather in
                ComparisionView(weather: weather)
            }
        }
    }
}

#Preview {
    WeatherVStack()
}
