//
//  +Double.swift
//  wotd
//
//  Created by EMILY on 26/03/2024.
//

import Foundation

extension Double {
    // 반올림 한 뒤 Int로 형변환
    func int() -> Int {
        return Int(self.rounded())
    }
}
