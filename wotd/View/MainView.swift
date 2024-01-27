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
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "location.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, alignment: .leading)
                
                Text(nm.location)
                    .font(.title)
                    .bold()
                
                Spacer()
            }
            
            SmallRect(day: nm.yesterday)
            
            BigRect(day: nm.today)
            
            SmallRect(day: nm.tomorrow)
        }
        .padding(.horizontal, 15)
        .onAppear(perform: {
            nm.setDateInfo()
            lm.requestLocation()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                print(nm.today.isDaytime)
                print(nm.yesterday.temp)
                print(nm.tomorrow.formattedMinTemp)
            }
        })
    }
}

#Preview {
    MainView()
}
