//
//  AppearanceType.swift
//  wotd
//
//  Created by EMILY on 08/07/2024.
//

import SwiftUI

enum AppearanceType: CaseIterable {
    case system
    case light
    case dark
    
    var label: LocalizedStringResource {
        switch self {
        case .system:
            return "System Mode"
        case .light:
            return "Light Mode"
        case .dark:
            return "Dark Mode"
        }
    }
    
    var image: Image {
        switch self {
        case .system:
            Image("system")
        case .light:
            Image(systemName: "sun.max")
        case .dark:
            Image(systemName: "moon.circle")
        }
    }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
