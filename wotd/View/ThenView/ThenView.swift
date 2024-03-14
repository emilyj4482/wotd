//
//  ThenView.swift
//  wotd
//
//  Created by EMILY on 12/03/2024.
//

import SwiftUI

struct ThenView: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Image(systemName: "cloud.sun.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .symbolRenderingMode(.multicolor)
                    .padding()
                
                Text("Add a weather of the specific day and city you want to compare to today's one.")
                
                Spacer()
            }
            .padding()
            
            
            VStack {
                Spacer()
                
                Button {
                    isPresented.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                        .tint(.black2)
                }
                .shadow(color: .black2.opacity(0.2), radius: 5, x: 3, y: 3)
                .padding(.bottom, 30)
            }
        }
        .frame(maxWidth: .infinity)
        .background(.black.opacity(0.05))
        
        .sheet(isPresented: $isPresented, content: {
            AddSheet()
                .presentationDetents([.height(300)])
        })
    }
}

#Preview {
    ThenView()
}
