//
//  TempProgressView.swift
//  wotd
//
//  Created by EMILY on 23/04/2024.
//

import SwiftUI

struct TempProgressView: View {
    
    // @Binding var weather: ThenWeather
    let weather: ThenWeather
    @Binding var tempRange: ClosedRange<Double>
    
    var body: some View {
        HStack {
            Text("\(weather.min)")
            
            ProgressView()
                .progressViewStyle(RangedProgressView(range: tempRange, foregroundColor: AnyShapeStyle(gradient), backgroundColor: backgroundColor))
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
    ComparisionView(weather: ThenViewModel.shared.thenDummy)
}
