//
//  SmallRect.swift
//  wotd
//
//  Created by EMILY on 28/01/2024.
//

import SwiftUI

struct SmallRect: View {
    
    @ObservedObject private var vm = NowViewModel.shared
    
    let isYesterday: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.smallRectGradient(isYesterday ? vm.yesterday.colors : vm.tomorrow.colors))
                .frame(height: 180)
                .clipShape(.rect(cornerRadius: 15))
                .shadow(color: .black.opacity(0.2), radius: 50, x: -10, y: -10)
                
            HStack {
                VStack(alignment: .leading) {
                    Text(isYesterday ? vm.yesterday.day : vm.tomorrow.day)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(isYesterday ? vm.yesterday.temp.toString : vm.tomorrow.temp.toString)
                        .font(.system(size: 50))
                    
                    Text("max \(isYesterday ? vm.yesterday.maxTemp.toString : vm.tomorrow.maxTemp.toString) min \(isYesterday ? vm.yesterday.minTemp.toString : vm.tomorrow.minTemp.toString)")
                        .font(.subheadline)
                }
                Spacer()
                
                VStack {
                    Image(systemName: isYesterday ? vm.yesterday.icon : vm.tomorrow.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                        .symbolRenderingMode(.multicolor)
                    
                    Text(isYesterday ? vm.yesterday.description : vm.tomorrow.description)
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
