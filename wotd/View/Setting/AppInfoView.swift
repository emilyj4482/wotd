//
//  AppInfoView.swift
//  wotd
//
//  Created by EMILY on 11/07/2024.
//

import SwiftUI

struct AppInfoView: View {
    var body: some View {
        VStack {
            List {
                Section("App") {
                    GroupBox("wotd?") {
                        Text("""
                        wotd is short for \(Text("W").bold())eather \(Text("O").bold())f \(Text("T").bold())he \(Text("D").bold())ay.\nIt started from the idea that how I want to compare today's weather to specific day's weather I remember whether it's colder or hotter.
                        """)
                        .font(.footnote)
                    }
                    .groupBoxStyle(.custom)
                }
                
                Section("Developer") {
                    HStack(spacing: 13) {
                        Text("👩🏻‍💻")
                            .padding(.leading, -3)
                        Text("Emily")
                    }
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
        }
        .navigationTitle("wotd")
    }
}

extension AppInfoView {
    @ViewBuilder
    func boldLetter(_ letter: String) -> some View {
        Text(letter.uppercased()).bold()
    }
}

#Preview {
    AppInfoView()
}
