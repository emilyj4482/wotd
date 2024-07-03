//
//  SettingView.swift
//  wotd
//
//  Created by EMILY on 27/06/2024.
//

import SwiftUI

struct SettingView: View {
    
    @State private var version: String = "1.0.0"
    @State private var isLatest: Bool = true
    
    var body: some View {
        NavigationStack {
            List {
                Section("Info") {
                    VStack(alignment: .leading) {
                        Text("Version")
                        Text("\(version) \(isLatest ? "is up to date" : "needs update")")
                            .font(.caption)
                            .foregroundStyle(.primary.opacity(0.5))
                    }
                    NavigationLink("Data source") {
                        DataSourceView()
                    }
                }
                Section("Settings") {
                    Text("Display")
                }
            }
        }
    }
}

private struct DataSourceView: View {
    fileprivate var body: some View {
        Text("OpenWeather API")
    }
}

#Preview {
    SettingView()
}
