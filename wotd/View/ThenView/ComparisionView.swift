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
        VStack {
            Text(weather.date)
                .font(.title)
            Text(weather.city)
                .font(.title2).bold()
        }
    }
}

#Preview {
    ComparisionView(weather: ThenWeather(date: "2023-10-20", city: "London", min: 0, max: 0, morning: 0, afternoon: 0, evening: 0, night: 0))
}
