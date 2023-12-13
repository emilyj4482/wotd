//
//  LocationInfo.swift
//  wotd
//
//  Created by EMILY on 01/12/2023.
//

import Foundation

struct LocationInfo: Decodable {
    let location: [Location]
    
    enum CodingKeys: String, CodingKey {
        case location = "documents"
    }
}

struct Location: Decodable {
    let x: String
    let y: String
    let address: Address
    
    enum CodingKeys: String, CodingKey {
        case x
        case y
        case address
    }
    
}

struct Address: Decodable {
    let depth1: String
    let depth2: String
    let depth3: String
    
    enum CodingKeys: String, CodingKey {
        case depth1 = "region_1depth_name"
        case depth2 = "region_2depth_name"
        case depth3 = "region_3depth_name"
    }
}
