//
//  LocationInfo.swift
//  wotd
//
//  Created by EMILY on 21/12/2023.
//

import Foundation

struct LocationInfo: Decodable {
    let location: [Address]
    
    enum CodingKeys: String, CodingKey {
        case location = "documents"
    }
}
