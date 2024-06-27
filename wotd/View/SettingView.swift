//
//  SettingView.swift
//  wotd
//
//  Created by EMILY on 27/06/2024.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        List {
            Section("Info") {
                Text("Version")
                Text("Data source")
            }
            Section("Settings") {
                Text("Display")
            }
        }
    }
}

#Preview {
    SettingView()
}
