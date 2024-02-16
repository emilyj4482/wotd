//
//  +LinearGradient.swift
//  wotd
//
//  Created by EMILY on 09/02/2024.
//

import SwiftUI

extension ShapeStyle where Self == LinearGradient {
    static func bigRectGradient(_ colors: [Color]) -> LinearGradient {
        return LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    static func smallRectGradient(_ colors: [Color]) -> LinearGradient {
        let newColors = colors.map { $0.opacity(0.8) }
        return LinearGradient(colors: newColors, startPoint: .bottomLeading, endPoint: .topTrailing)
    }
}
