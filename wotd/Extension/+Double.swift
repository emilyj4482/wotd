//
//  +Double.swift
//  wotd
//
//  Created by EMILY on 26/03/2024.
//

import Foundation

extension Double {
    // 반올림 한 뒤 Int로 형변환
    var toInt: Int {
        Int(self.rounded())
    }
    
    // n.n°
    // >> api 통신을 통해 받은 data가 없을 경우 -로 표시
    var toString: String {
        if self == 1000.0 {
            return "-"
        } else if self > -0.05 && self <= 0 {
            // -0.0°로 표시되는 것 방지
            return "0.0°"
        } else {
            return "\(String(format: "%.1f", self))°"
        }
    }
}
