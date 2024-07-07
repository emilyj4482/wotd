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
        HStack {
            ForEach(vm.modes, id: \.self) { mode in
                Button(action: {
                    vm.changeAppearance(mode)
                    print(vm.appearance)
                }, label: {
                    VStack {
                        mode.image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        
                        Text(mode.label)
                    }
                })
                
            }
        }
        .preferredColorScheme(vm.appearance.colorScheme)
    }
}

#Preview {
    AppearanceSettingView(vm: SettingViewModel())
}
