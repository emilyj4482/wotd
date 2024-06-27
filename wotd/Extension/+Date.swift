//
//  +Date.swift
//  wotd
//
//  Created by EMILY on 25/03/2024.
//

import Foundation

extension Date {
    // 날짜 + 현재 시각을 timestamp로 변환
    var dtString: String {
        // Date type을 TimeInterval 형태로 변환
        let dt = self.timeIntervalSince1970
        // 소수점 버리고 정수로 변환
        let dtInteger = Int(floor(dt))
        
        return String(dtInteger)
    }
    
    // 날짜를 yyyy-mm-dd 형태의 문자열로 변환
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: self)
    }
    
    // 현재 시간이 day인지 night인지 구분하여 day면 true, night이면 false 반환
    var isDayTime: Bool {
        let hour = Calendar.current.component(.hour, from: self)
        
        if hour >= 6 && hour <= 17 {
            return true
        } else {
            return false
        }
    }
    
    var dateString2: String {
        guard let code = Locale.current.language.languageCode else { return "" }
        switch code {
        case .korean:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy년 M월 d일"
            return dateFormatter.string(from: self)
        default:
            return self.formatted(Date.FormatStyle().year().day().month().locale(Locale(identifier: "en")))
        }
    }
}
