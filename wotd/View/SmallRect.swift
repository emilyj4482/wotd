//
//  SmallRect.swift
//  wotd
//
//  Created by EMILY on 28/01/2024.
//

import SwiftUI

struct SmallRect: View {
    
    @State var day: CurrentWeather
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.opacity(0.85))
                .frame(height: 180)
                .clipShape(.rect(cornerRadius: 15))
                
            HStack {
                VStack(alignment: .leading) {
                    Text(day.day)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(day.formattedTemp)
                        .font(.system(size: 50))
                    
                    Text("max \(day.formattedMaxTemp) min \(day.formattedMinTemp)")
                        .font(.subheadline)
                }
                Spacer()
                
                Image(systemName: day.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .symbolRenderingMode(.multicolor)
                    .padding(.trailing, 30)
            }
            .padding(.horizontal, 30)
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    SmallRect(day: CurrentWeather(day: "Yesterday"))
}
