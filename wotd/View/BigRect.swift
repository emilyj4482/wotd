//
//  BigRect.swift
//  wotd
//
//  Created by EMILY on 28/01/2024.
//

import SwiftUI

struct BigRect: View {
    
    @State var day: CurrentWeather
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.opacity(0.9))
                .frame(height: 220)
                .clipShape(.rect(cornerRadius: 15))
                
            HStack {
                VStack(alignment: .leading) {
                    Text(NetworkManager.shared.today.day)
                        .font(.title)
                        .bold()
                    
                    Text(NetworkManager.shared.today.formattedTemp)
                        .font(.system(size: 60))
                    
                    Text("max \(NetworkManager.shared.today.formattedMaxTemp) min \(NetworkManager.shared.today.formattedMinTemp)")
                        .font(.callout)
                }
                Spacer()
                
                Image(systemName: NetworkManager.shared.today.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .symbolRenderingMode(.multicolor)
                    .padding(.trailing, 20)
            }
            .padding(.horizontal, 30)
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    BigRect(day: CurrentWeather(day: "Today"))
}
