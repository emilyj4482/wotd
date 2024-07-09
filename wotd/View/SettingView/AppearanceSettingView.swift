//
//  AppearanceSettingView.swift
//  wotd
//
//  Created by EMILY on 08/07/2024.
//

import SwiftUI

struct AppearanceSettingView: View {
    
    @ObservedObject var vm: SettingViewModel
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 100)
            
            HStack(spacing: 11) {
                ForEach(vm.modes, id: \.self) { mode in
                    Button(action: {
                        vm.changeAppearance(mode)
                    }, label: {
                        VStack(spacing: 5) {
                            mode.image
                                .font(.largeTitle)
                            
                            Text(mode.label)
                                .font(.subheadline)
                        }
                        .frame(width: 110, height: 110)
                        .background(
                            Color(
                                vm.appearance.colorScheme == mode.colorScheme ? .systemGray2
                                : .systemGray6)
                            .clipShape(.rect(cornerRadius: 20))
                        )
                        .shadow(color: Color(.systemGray2), radius: 1.5)
                    })
                }
            }
            
            Spacer()
        }
    }
}

#Preview {
    AppearanceSettingView(vm: SettingViewModel(0))
}
