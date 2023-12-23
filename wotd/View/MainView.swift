//
//  MainView.swift
//  wotd
//
//  Created by EMILY on 20/12/2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        Image(systemName: Snow.light.systemName)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .symbolRenderingMode(.multicolor)
            .padding(50)
            .background(.black)
    }
}

#Preview {
    MainView()
}
