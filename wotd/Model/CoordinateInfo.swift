//
//  CoordinateInfo.swift
//  wotd
//
//  Created by EMILY on 01/12/2023.
//

import Foundation

struct CoordinateInfo: Decodable {
    let coordinate: [Coordinate]
    
    enum CodingKeys: String, CodingKey {
        case coordinate = "documents"
    }
}

struct Coordinate: Decodable {
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
