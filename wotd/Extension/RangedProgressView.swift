//
//  RangedProgressView.swift
//  wotd
//
//  Created by EMILY on 14/04/2024.
//

import SwiftUI

struct RangedProgressView: ProgressViewStyle {
    
    let range: ClosedRange<Double>
    let foregroundColor: AnyShapeStyle
    let backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        return GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(backgroundColor)
                Capsule()
                    .fill(foregroundColor)
                    .frame(width: proxy.size.width * fillWidthScale)
                    .offset(x: proxy.size.width * range.lowerBound)
            }
        }
    }
    
    var fillWidthScale: Double {
        let normalizedRange = range.upperBound - range.lowerBound
        return Double(normalizedRange)
    }
    
}
