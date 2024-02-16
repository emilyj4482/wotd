//
//  BigRect.swift
//  wotd
//
//  Created by EMILY on 28/01/2024.
//

import SwiftUI

struct BigRect: View {
    
    @ObservedObject private var nm = NetworkManager.shared
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.bigRectGradient(nm.today.colors))
                .frame(height: 220)
                .clipShape(.rect(cornerRadius: 15))
                .shadow(color: .black.opacity(0.4), radius: 20, x: 10, y: 10)
                
            HStack {
                VStack(alignment: .leading) {
                    Text(nm.today.day)
                        .font(.title)
                        .bold()
                    
                    Text(nm.today.formattedTemp)
                        .font(.system(size: 60))
                    
                    Text("max \(nm.today.formattedMaxTemp) min \(nm.today.formattedMinTemp)")
                        .font(.callout)
                }
                
                Spacer()
                
                VStack {
                    Image(systemName: nm.today.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .symbolRenderingMode(.multicolor)
                    Text(nm.today.description)
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

#Preview {
    MainView()
}
