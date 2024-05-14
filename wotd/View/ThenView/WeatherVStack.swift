//
//  WeatherVStack.swift
//  wotd
//
//  Created by EMILY on 06/04/2024.
//

import SwiftUI

struct WeatherVStack: View {
    
    @StateObject var vm = ThenViewModel.shared
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.weathers, id: \.self) { weather in
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
