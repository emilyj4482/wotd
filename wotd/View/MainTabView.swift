//
//  MainTabView.swift
//  wotd
//
//  Created by EMILY on 12/03/2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("Now")
                }
            
            Text("Hello, World!")
                .tabItem {
                    Image(systemName: "calendar.badge.plus")
                    Text("Then")
                }
        }
        .tint(Color(.label))
    }
}

#Preview {
    MainTabView()
}
