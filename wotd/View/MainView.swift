//
//  MainView.swift
//  wotd
//
//  Created by EMILY on 20/12/2023.
//

import SwiftUI

struct MainView: View {
    
    @State var currentLocation: String = "수원시 장안구"
    @State var currentTemp: String = "7.2"
    @State var weatherIcon: String = Rain.drizzle.systemName
    
    @State var maxTemp: Int = 10
    @State var minTemp: Int = 3
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "location.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, alignment: .leading)
                
                Text("\(currentLocation)")
                    .font(.title)
                    .bold()
                
                Spacer()
            }
            
            ZStack {
                Rectangle()
                    .foregroundStyle(.opacity(0.85))
                    .frame(height: 180)
                    .clipShape(.rect(cornerRadius: 15))
                    
                HStack {
                    VStack(alignment: .leading) {
                        Text("Yesterday")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("\(currentTemp)°")
                            .font(.system(size: 50))
                        
                        Text("max \(maxTemp)° min \(minTemp)°")
                            .font(.subheadline)
                    }
                    Spacer()
                    
                    Image(systemName: weatherIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .symbolRenderingMode(.multicolor)
                        .padding(.trailing, 30)
                }
                .padding(.horizontal, 30)
                .foregroundStyle(.white)
            }
            
            ZStack {
                Rectangle()
                    .foregroundStyle(.opacity(0.9))
                    .frame(height: 220)
                    .clipShape(.rect(cornerRadius: 15))
                    
                HStack {
                    VStack(alignment: .leading) {
                        Text("Today")
                            .font(.title)
                            .bold()
                        
                        Text("\(currentTemp)°")
                            .font(.system(size: 60))
                        
                        Text("max \(maxTemp)° min \(minTemp)°")
                            .font(.callout)
                    }
                    Spacer()
                    
                    Image(systemName: weatherIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .symbolRenderingMode(.multicolor)
                        .padding(.trailing, 20)
                }
                .padding(.horizontal, 30)
                .foregroundStyle(.white)
            }
            
            ZStack {
                Rectangle()
                    .foregroundStyle(.opacity(0.85))
                    .frame(height: 180)
                    .clipShape(.rect(cornerRadius: 15))
                    
                HStack {
                    VStack(alignment: .leading) {
                        Text("Tomorrow")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("\(currentTemp)°")
                            .font(.system(size: 50))
                        
                        Text("max \(maxTemp)° min \(minTemp)°")
                            .font(.subheadline)
                    }
                    Spacer()
                    
                    Image(systemName: weatherIcon)
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
        .padding(.horizontal, 10)
    }
}

#Preview {
    MainView()
}
