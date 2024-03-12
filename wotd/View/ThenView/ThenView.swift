//
//  ThenView.swift
//  wotd
//
//  Created by EMILY on 12/03/2024.
//

import SwiftUI

struct ThenView: View {
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
        }
        .frame(maxWidth: .infinity)
        .background(.black.opacity(0.05))
    }
}

#Preview {
    ThenView()
}
