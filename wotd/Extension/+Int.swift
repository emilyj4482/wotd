//
//  +Int.swift
//  wotd
//
//  Created by EMILY on 27/05/2024.
//

import SwiftUI

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
    
    var toTempColor: Color {
        if self < 0 {
            return Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1))
        } else if self >= 0 && self < 5 {
            return Color(#colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1))
        } else if self >= 5 && self < 10 {
            return Color(#colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1))
        } else if self >= 10 && self < 13 {
            return Color(#colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 1))
        } else if self >= 13 && self < 16 {
            return Color(#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1))
        } else if self >= 16 && self < 23 {
            return Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1))
        } else if self >= 23 && self < 27 {
            return Color(#colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1))
        }else if self >= 27 && self < 35 {
            return Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1))
        } else {
            return Color(#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1))
        }
    }
}
