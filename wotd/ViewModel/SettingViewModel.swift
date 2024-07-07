//
//  SettingViewModel.swift
//  wotd
//
//  Created by EMILY on 08/07/2024.
//

import Foundation

final class SettingViewModel: ObservableObject {
    @Published var appearance: AppearanceType = .system
    let modes: [AppearanceType] = AppearanceType.allCases
    
    func changeAppearance(_ willBeAppearance: AppearanceType) {
        appearance = willBeAppearance
    }
}
