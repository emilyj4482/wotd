//
//  TempProgressView.swift
//  wotd
//
//  Created by EMILY on 23/04/2024.
//

import SwiftUI

struct TempProgressView: View {
    
    @Binding var weather: ThenWeather
    @Binding var tempRange: ClosedRange<Double>
    
    var body: some View {
        HStack {
            Text(weather.min.toString)
            
            ProgressView()
                .progressViewStyle(RangedProgressView(range: tempRange, foregroundColor: AnyShapeStyle(gradient), backgroundColor: .progressBar))
                .frame(maxWidth: 250, maxHeight: 7)
                .padding(.horizontal)
                .shadow(radius: 1)
            
            Text(weather.max.toString)
        }
        .padding(.horizontal, 20)
    }
    
    var gradient: LinearGradient {
        return LinearGradient(colors: [weather.min.toTempColor, weather.max.toTempColor], startPoint: .leading, endPoint: .trailing)
    }
}

#Preview {
    ComparisionView(weather: ThenWeather(date: Date(), city: "수원시", min: 3, max: 10, morning: 0, afternoon: 3, evening: 2, night: 1))
}
