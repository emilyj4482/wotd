//
//  +GroupBoxStyle.swift
//  wotd
//
//  Created by EMILY on 11/07/2024.
//

import SwiftUI

struct DescriptionGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .bold()
                .font(.title3)
            configuration.content
                .offset(y: 1)
        }
        .padding(8)
    }
}

extension GroupBoxStyle where Self == DescriptionGroupBoxStyle {
    static var custom: DescriptionGroupBoxStyle { .init() }
}
