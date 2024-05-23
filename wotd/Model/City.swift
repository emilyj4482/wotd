//
//  City.swift
//  wotd
//
//  Created by EMILY on 18/03/2024.
//

import Foundation
import MapKit

struct City: Identifiable {
    let id = UUID()
    var name: String
    var fullName: String
    
    init(mapItem: MKMapItem) {
        self.name = mapItem.name ?? ""
        self.fullName = mapItem.placemark.title ?? ""
    }
}
