//
//  AppStorageKey.swift
//  wotd
//
//  Created by EMILY on 30/08/2025.
//

import Foundation

struct AppStorageKey {
    static let key: String = "colorScheme"
    static let defaultValue: Int = UserDefaults.standard.integer(forKey: key)
}
