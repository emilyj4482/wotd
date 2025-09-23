//
//  SmallRect.swift
//  wotd
//
//  Created by EMILY on 28/01/2024.
//

import SwiftUI

struct SmallRect: View {
    @Binding var weather: NowWeather
    let isYesterday: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.smallRectGradient(weather.colors))
                .frame(height: 180)
                .clipShape(.rect(cornerRadius: 15))
                .shadow(color: .black.opacity(0.2), radius: 50, x: -10, y: -10)
                
            HStack {
                VStack(alignment: .leading) {
                    Text(isYesterday ? "Yesterday" : "Tomorrow")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(weather.temp.toString)
                        .font(.system(size: 50))
                    
                    Text("max \(weather.maxTemp.toString) min \(weather.minTemp.toString)")
                        .font(.subheadline)
                }
                Spacer()
                
                VStack {
                    Image(systemName: weather.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                        .symbolRenderingMode(.multicolor)
                    
                    Text(weather.description)
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(.top, 5)
                }
                .shadow(radius: 5)
                .padding(.trailing, 30)
            }
            .padding(.horizontal, 30)
            .foregroundStyle(.white)
        }
    }
}
