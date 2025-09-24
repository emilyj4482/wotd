//
//  DefaultVStack.swift
//  wotd
//
//  Created by EMILY on 29/03/2024.
//

import SwiftUI

struct DefaultVStack: View {
    var body: some View {
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
}

#Preview {
    DefaultVStack()
}
