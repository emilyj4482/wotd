//
//  WeatherGradient.swift
//  wotd
//
//  Created by EMILY on 09/02/2024.
//

import SwiftUI

/*
struct WeatherGradient: ShapeStyle {
    var body: LinearGradient {
        LinearGradient(colors: [.orange, .yellow, .green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
*/

extension ShapeStyle {
    static func weatherGradient() -> LinearGradient {
        return LinearGradient(colors: [.orange, .yellow, .green, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
