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
    
    let versionText1: LocalizedStringResource = "is up to date"
    let versionText2: LocalizedStringResource = "needs update"
    
    var body: some View {
        NavigationStack {
            List {
                Section("Info") {
                    VStack(alignment: .leading) {
                        Text("Version")
                        Text("\(version) \(isLatest ? versionText1 : versionText2)")
                            .font(.caption)
                            .foregroundStyle(.primary.opacity(0.5))
                    }
                    NavigationLink("Data source") {
                        DataSourceView()
                    }
                    NavigationLink("Developer") {
                        DeveloperView()
                    }
                }
                Section("Settings") {
                    NavigationLink("Appearance") {
                        AppearanceSettingView(vm: SettingViewModel())
                    }
                }
            }
            .navigationTitle("wotd")
        }
    }
}

private struct DataSourceView: View {
    fileprivate var body: some View {
        VStack(spacing: 5) {
            Text("This app's weather data comes from:")
            Text("OpenWeather API")
                .font(.title2)
            Link(destination: URL(string: "https://openweathermap.org")!, label: {
                Text("openweathermap.org")
                    .tint(.blue)
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
    }
}

private struct DeveloperView: View {
    fileprivate var body: some View {
        VStack {
            List {
                HStack(spacing: 13) {
                    Image(systemName: "envelope.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                    Text("emilyj4482@outlook.com")
                }
                HStack(spacing: 13) {
                    Image("github")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                    Link(destination: URL(string: "https://github.com/emilyj4482")!, label: {
                        Text("github.com/emilyj4482")
                    })
                }
            }
        }
        .navigationTitle("Emily👩🏻‍💻")
    }
}

#Preview {
    NavigationView {
        SettingView()
    }
}
