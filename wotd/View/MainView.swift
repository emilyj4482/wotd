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
            
            SmallRect(isYesterday: true)
            
            BigRect()
            
            SmallRect(isYesterday: false)
        }
        .padding(.horizontal, 17)
        .onAppear(perform: {
            nm.setDateInfo()
            lm.requestLocation()
        })
    }
}

#Preview {
    MainView()
}
