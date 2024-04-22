//
//  TempProgressView.swift
//  wotd
//
//  Created by EMILY on 23/04/2024.
//

import SwiftUI

struct TempProgressView: View {
    
    @Binding var weather: ThenWeather
    
    var body: some View {
        HStack {
            Text("\(weather.min)")
            
            ProgressView()
                .progressViewStyle(RangedProgressView(range: 0.2...0.7/1.0, foregroundColor: AnyShapeStyle(gradient), backgroundColor: backgroundColor))
                .frame(maxWidth: 250, maxHeight: 7)
                .padding(.horizontal)
            
            Text("\(weather.max)")
        }
        .padding(.horizontal, 20)
    }
    
    var gradientColors: [Color] {
        return [
            Color(red: 0.39, green: 0.8, blue: 0.74),
            Color(red: 0.96, green: 0.8, blue: 0.0)
        ]
    }
    
    var gradient: LinearGradient {
        return LinearGradient(colors: gradientColors, startPoint: .leading, endPoint: .trailing)
    }
    
    var backgroundColor: Color {
        return Color(red: 0.25, green: 0.35, blue: 0.72).opacity(0.13)
    }
}

#Preview {
    ComparisionView(weather: ThenWeather(date: "2023-10-20", city: "London", min: -1, max: 13, morning: -1, afternoon: 2, evening: 11, night: 13))
}
