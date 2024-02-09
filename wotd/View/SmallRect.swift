//
//  SmallRect.swift
//  wotd
//
//  Created by EMILY on 28/01/2024.
//

import SwiftUI

struct SmallRect: View {
    
    @ObservedObject private var nm = NetworkManager.shared
    
    let isYesterday: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.srClearGradient)
                // .fill(.linearGradient(colors: [.orange.opacity(0.8), .yellow.opacity(0.8), .green.opacity(0.8), .blue.opacity(0.8)], startPoint: .bottomLeading, endPoint: .topTrailing))
                .frame(height: 180)
                .clipShape(.rect(cornerRadius: 15))
                .shadow(color: .black.opacity(0.2), radius: 50, x: -10, y: -10)
                
            HStack {
                VStack(alignment: .leading) {
                    Text(isYesterday ? nm.yesterday.day : nm.tomorrow.day)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(isYesterday ? nm.yesterday.formattedTemp : nm.tomorrow.formattedTemp)
                        .font(.system(size: 50))
                    
                    Text("max \(isYesterday ? nm.yesterday.formattedMaxTemp : nm.tomorrow.formattedMaxTemp) min \(isYesterday ? nm.yesterday.formattedMinTemp : nm.tomorrow.formattedMinTemp)")
                        .font(.subheadline)
                }
                Spacer()
                
                Image(systemName: isYesterday ? nm.yesterday.icon : nm.tomorrow.icon)
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
    MainView()
}
