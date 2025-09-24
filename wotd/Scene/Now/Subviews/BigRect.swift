//
//  BigRect.swift
//  wotd
//
//  Created by EMILY on 28/01/2024.
//

import SwiftUI

struct BigRect: View {
    @Binding var weather: NowWeather
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.bigRectGradient(weather.colors))
                .frame(height: 220)
                .clipShape(.rect(cornerRadius: 15))
                .shadow(color: .black.opacity(0.4), radius: 20, x: 10, y: 10)
                
            HStack {
                VStack(alignment: .leading) {
                    Text("Today")
                        .font(.title)
                        .bold()
                    
                    Text(weather.temp.toString)
                        .font(.system(size: 60))
                    
                    Text("max \(weather.maxTemp.toString) min \(weather.minTemp.toString)")
                        .font(.callout)
                }
                
                Spacer()
                
                VStack {
                    Image(systemName: weather.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .symbolRenderingMode(.multicolor)
                    Text(weather.description)
                        .font(.callout)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.leading)
                }
                
                .padding(.trailing, 20)
            }
            .shadow(radius: 5)
            .padding(.horizontal, 30)
            .foregroundStyle(.white)
        }
    }
}
