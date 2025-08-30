//
//  wotdApp.swift
//  wotd
//
//  Created by EMILY on 01/12/2023.
//

import SwiftUI

@main
struct wotdApp: App {
    
    @AppStorage(AppStorageKey.key) var colorSchemeValue: Int = AppStorageKey.defaultValue
    
    var body: some Scene {
        WindowGroup {
            MainTabView(lm: LocationManager(), settingVM: SettingViewModel(colorSchemeValue))
        }
    }
}
