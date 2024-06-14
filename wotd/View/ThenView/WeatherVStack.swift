//
//  WeatherVStack.swift
//  wotd
//
//  Created by EMILY on 06/04/2024.
//

import SwiftUI

struct WeatherVStack: View {
    
    @EnvironmentObject var lm: LocationManager
    
    @StateObject var vm = ThenViewModel.shared
    
    @State private var weatherToDelete: ThenWeather? = nil
    @State private var isActionSheetPresented: Bool = false
    @State private var isAlertPresented: Bool = false
    
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
                            isActionSheetPresented = true
                        } label: {
                            Image(systemName: "trash")
                                .tint(.red)
                        }
                    }
                }
            }
            .confirmationDialog("Delete this weather?", isPresented: $isActionSheetPresented, titleVisibility: .visible) {
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
            .onAppear(perform: {
                if lm.locationManager.authorizationStatus == .denied {
                    isAlertPresented = true
                }
            })
            .alert("Authorization Denied", isPresented: $isAlertPresented) {
                
            } message: {
                Text("We cannot compare weathers as access to location infomation is not allowed. Please go to Settings and allow the authorization.")
            }
        }
    }
}

#Preview {
    WeatherVStack()
        .environmentObject(LocationManager())
}
