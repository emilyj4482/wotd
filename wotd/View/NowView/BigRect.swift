//
//  BigRect.swift
//  wotd
//
//  Created by EMILY on 28/01/2024.
//

import SwiftUI

struct BigRect: View {
    
    @ObservedObject private var vm = NowViewModel.shared
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.bigRectGradient(vm.today.colors))
                .frame(height: 220)
                .clipShape(.rect(cornerRadius: 15))
                .shadow(color: .black.opacity(0.4), radius: 20, x: 10, y: 10)
                
            HStack {
                VStack(alignment: .leading) {
                    Text(vm.today.day)
                        .font(.title)
                        .bold()
                    
                    Text(vm.today.temp.toString)
                        .font(.system(size: 60))
                    
                    Text("max \(vm.today.maxTemp.toString) min \(vm.today.minTemp.toString)")
                        .font(.callout)
                }
                
                Spacer()
                
                VStack {
                    Image(systemName: vm.today.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .symbolRenderingMode(.multicolor)
                    Text(vm.today.description)
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
    NowView()
}
