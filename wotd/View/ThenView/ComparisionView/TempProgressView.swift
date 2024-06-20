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
                .progressViewStyle(RangedProgressView(range: tempRange, foregroundColor: AnyShapeStyle(gradient), backgroundColor: backgroundColor))
                .frame(maxWidth: 250, maxHeight: 7)
                .padding(.horizontal)
                .shadow(radius: 1)
            
            Text(weather.max.toString)
        }
        .padding(.horizontal, 20)
    }
    
    var gradientColors: [Color] {
        return [weather.min.toTempColor, weather.max.toTempColor]
    }
    
    var gradient: LinearGradient {
        return LinearGradient(colors: gradientColors, startPoint: .leading, endPoint: .trailing)
    }
    
    var backgroundColor: Color {
        return Color(red: 0.25, green: 0.35, blue: 0.72).opacity(0.13)
    }
}

#Preview {
    ComparisionView(weather: ThenWeather(date: Date(), city: "수원시", min: 3, max: 10, morning: 0, afternoon: 3, evening: 2, night: 1))
}
