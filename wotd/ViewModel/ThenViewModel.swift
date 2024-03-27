//
//  ThenViewModel.swift
//  wotd
//
//  Created by EMILY on 28/03/2024.
//

import Foundation

final class ThenViewModel: ObservableObject {
    
    static let shared = ThenViewModel()
    
    @Published var weathers: [ThenWeather] = []
    
}
