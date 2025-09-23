//
//  LocationError.swift
//  wotd
//
//  Created by EMILY on 22/09/2025.
//

import Foundation

enum LocationError: Error {
    case geocoderFailed
    
    var errorMessage: LocalizedStringResource {
        switch self {
        case .geocoderFailed:
            return "[LocationError] Failed to get location from geocoder."
        }
    }
}
