//
//  NowView.swift
//  wotd
//
//  Created by EMILY on 20/12/2023.
//

import SwiftUI

struct NowView: View {
    @StateObject var viewModel = NowViewModel()
    
    @State private var isPresented: Bool = false
    @State private var errorMessage: LocalizedStringResource = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "location.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, alignment: .leading)
                
                Text(viewModel.cityName)
                    .font(.title)
                    .bold()
                
                Spacer()
            }
            
            SmallRect(weather: $viewModel.yesterday, isYesterday: true)
            
            BigRect(weather: $viewModel.today)
            
            SmallRect(weather: $viewModel.tomorrow, isYesterday: false)
        }
        .padding(.horizontal, 17)
        .onReceive(viewModel.$error, perform: { error in
            guard let error else { return }
            switch error {
            case let locationError as LocationError:
                errorMessage = locationError.errorMessage
            case let networkError as NetworkError:
                errorMessage = networkError.errorMessage
            default:
                errorMessage = "Unknown Error occured. Please try again later."
            }
            isPresented = true
        })
        .alert("Error", isPresented: $isPresented) {
            
        } message: {
            Text(errorMessage)
        }
    }
}
