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
                .fill(.smallRectGradient(isYesterday ? nm.yesterday.colors : nm.tomorrow.colors))
                .frame(height: 180)
                .clipShape(.rect(cornerRadius: 15))
                .shadow(color: .black.opacity(0.2), radius: 50, x: -10, y: -10)
                
            HStack {
                VStack(alignment: .leading) {
                    Text(isYesterday ? nm.yesterday.day : nm.tomorrow.day)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(isYesterday ? nm.yesterday.temp.toString : nm.tomorrow.temp.toString)
                        .font(.system(size: 50))
                    
                    Text("max \(isYesterday ? nm.yesterday.maxTemp.toString : nm.tomorrow.maxTemp.toString) min \(isYesterday ? nm.yesterday.minTemp.toString : nm.tomorrow.minTemp.toString)")
                        .font(.subheadline)
                }
                Spacer()
                
                VStack {
                    Image(systemName: isYesterday ? nm.yesterday.icon : nm.tomorrow.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                        .symbolRenderingMode(.multicolor)
                    
                    Text(isYesterday ? nm.yesterday.description : nm.tomorrow.description)
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

#Preview {
    NowView()
}
