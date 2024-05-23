//
//  WeatherVStack.swift
//  wotd
//
//  Created by EMILY on 06/04/2024.
//

import SwiftUI

struct WeatherVStack: View {
    
    @StateObject var vm = ThenViewModel.shared
    
    @State private var weatherToDelete: ThenWeather? = nil
    @State private var showActionSheet: Bool = false
    
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
                    .swipeActions(allowsFullSwipe: false) {
                        Button {
                            weatherToDelete = weather
                            print(weather)
                            showActionSheet = true
                        } label: {
                            Image(systemName: "trash")
                                .tint(.red)
                        }
                    }
                }
            }
            .confirmationDialog("Delete this weather?", isPresented: $showActionSheet, titleVisibility: .visible) {
                Button("Delete", role: .destructive) {
                    if let weather = weatherToDelete {
                        vm.deleteWeather(weather)
                    }
                    weatherToDelete = nil
                }
                Button("Cancel", role: .cancel) {}
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
