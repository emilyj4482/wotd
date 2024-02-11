//
//  +LinearGradient.swift
//  wotd
//
//  Created by EMILY on 09/02/2024.
//

import SwiftUI

/*
struct WeatherGradient {
    var weatherGradient: some ShapeStyle {
        LinearGradient(colors: [.orange, .yellow, .green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
*/
extension ShapeStyle where Self == LinearGradient {
    static var brClearGradient: LinearGradient {
        LinearGradient(colors: [.orange, .yellow, .green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    static var srClearGradient: LinearGradient {
        LinearGradient(colors: [.orange.opacity(0.8), .yellow.opacity(0.8), .green.opacity(0.8), .blue.opacity(0.8)], startPoint: .bottomLeading, endPoint: .topTrailing)
    }
    
    static func bigRectGradient(_ colors: [Color]) -> LinearGradient {
        return LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    static func smallRectGradient(_ colors: [Color]) -> LinearGradient {
        let newColors = colors.map { $0.opacity(0.8) }
        return LinearGradient(colors: newColors, startPoint: .bottomLeading, endPoint: .topTrailing)
    }
}
