//
//  SettingViewModel.swift
//  wotd
//
//  Created by EMILY on 08/07/2024.
//

import SwiftUI

final class SettingViewModel: ObservableObject {
    @Published var appearance: AppearanceType
    let modes: [AppearanceType] = AppearanceType.allCases
    @AppStorage(AppStorageKey.key) var colorSchemeValue: Int = AppStorageKey.defaultValue
    
    init(_ colorSchemeValue: Int) {
        // init 시 app storage에 저장된 설정값을 불러온다. 없을 시 system
        self.appearance = AppearanceType(rawValue: colorSchemeValue) ?? .system
    }
    
    func changeAppearance(_ willBeAppearance: AppearanceType) {
        appearance = willBeAppearance
        colorSchemeValue = willBeAppearance.rawValue
    }
}
