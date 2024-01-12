//
//  MainView.swift
//  wotd
//
//  Created by EMILY on 20/12/2023.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var nm = NetworkManager.shared
    @StateObject var lm = LocationManager()
    
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
                
                Text("\(nm.today.location)")
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
                        
                        Text("\(formatTemp(nm.today.temp))°")
                            .font(.system(size: 60))
                        
                        Text("max \(nm.today.maxTemp)° min \(nm.today.minTemp)°")
                            .font(.callout)
                    }
                    Spacer()
                    
                    Image(systemName: nm.today.icon)
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
        .onAppear(perform: {
            nm.setToday()
            lm.requestLocation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                print(nm.today)
            }
        })
    }
}

extension MainView {
    // 소수점 첫번째 자리까지 표시
    func formatTemp(_ temp: Double) -> String {
        return String(format: "%.1f", temp)
    }
}

#Preview {
    MainView()
}
