//
//  MainTabView.swift
//  wotd
//
//  Created by EMILY on 12/03/2024.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var lm: LocationManager
    @StateObject var settingVM: SettingViewModel
    
    var body: some View {
        TabView {
            NowView()
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("Now")
                }
            
            ThenView()
                .tabItem {
                    Image(systemName: "calendar.badge.plus")
                    Text("Then")
                }
            
            SettingView(vm: settingVM)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .tint(.black2)
        .environmentObject(lm)
        .preferredColorScheme(settingVM.appearance.colorScheme)
    }
}

#Preview {
    MainTabView(lm: LocationManager(), settingVM: SettingViewModel(0))
}
