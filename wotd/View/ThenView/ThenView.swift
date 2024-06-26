//
//  ThenView.swift
//  wotd
//
//  Created by EMILY on 12/03/2024.
//

import SwiftUI

struct ThenView: View {
    
    @StateObject var vm = ThenViewModel.shared
    
    @State private var isSheetPresented: Bool = false
    
    var body: some View {
        ZStack {
            
            if vm.weathers.isEmpty {
                DefaultVStack()
            } else {
                WeatherVStack()
            }
            
            VStack {
                Spacer()
                
                Button {
                    isSheetPresented.toggle()
                } label: {
                    if !vm.isAddButtonHidden {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                            .tint(.gray2)
                    }
                }
                .shadow(color: .gray2.opacity(0.5), radius: 1, x: 1.5, y: 1.5)
                .padding(.bottom, 30)
            }
        }
        .frame(maxWidth: .infinity)
        .background(.black.opacity(0.05))
        .sheet(isPresented: $isSheetPresented, content: {
            AddSheet()
                .presentationDetents([.height(300)])
        })
    }
}

#Preview {
    ThenView()
}
