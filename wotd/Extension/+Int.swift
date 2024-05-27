//
//  +Int.swift
//  wotd
//
//  Created by EMILY on 27/05/2024.
//

import Foundation

extension Int {
    // n°
    // >> api 통신을 통해 받은 data가 없을 경우 -로 표시
    var toString: String {
        if self == 1000 {
            return "-"
        } else {
            return "\(self)°"
        }
    }
}
