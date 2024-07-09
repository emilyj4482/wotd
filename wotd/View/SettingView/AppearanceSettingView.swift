//
//  AppearanceSettingView.swift
//  wotd
//
//  Created by EMILY on 08/07/2024.
//

import SwiftUI

struct AppearanceSettingView: View {
    
    @StateObject var vm: SettingViewModel
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 100)
            
            HStack(spacing: 10) {
                ForEach(vm.modes, id: \.self) { mode in
                    Button(action: {
                        vm.changeAppearance(mode)
                        print(vm.appearance)
                    }, label: {
                        VStack(spacing: 5) {
                            mode.image
                                .font(.largeTitle)
                            
                            Text(mode.label)
                        }
                        .frame(width: 100, height: 100)
                        .background(Color(.secondarySystemBackground).clipShape(.rect(cornerRadius: 20)))
                    })
                    
                }
            }
            
            Spacer()
        }
        .preferredColorScheme(vm.appearance.colorScheme)
    }
}

#Preview {
    AppearanceSettingView(vm: SettingViewModel())
}
