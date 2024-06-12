//
//  NowView.swift
//  wotd
//
//  Created by EMILY on 20/12/2023.
//

import SwiftUI

struct NowView: View {
    
    @EnvironmentObject var lm: LocationManager
    
    @StateObject var vm = NowViewModel.shared
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "location.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, alignment: .leading)
                
                Text(vm.location)
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
            if lm.locationManager.authorizationStatus == .denied {
                isPresented = true
            }
        })
        .alert("Authorization Denied", isPresented: $isPresented) {
            
        } message: {
            Text("Access to location infomation is not allowed. Please go to Settings and allow the authorization.")
        }
    }
}

#Preview {
    NowView()
}
