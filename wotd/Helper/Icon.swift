//
//  Icon.swift
//  wotd
//
//  Created by EMILY on 24/12/2023.
//

import Foundation

enum Clear {
    case day
    case night
    
    var systemName: String {
        switch self {
        case .day:
            "sun.max.fill"
        case .night:
            "moon.fill"
        }
    }
}

enum Clouds {
    case moderate
    case overcast
    
    var systemName: String {
        switch self {
        case .moderate:
            "cloud.fill"
        case .overcast:
            "smoke.fill"
        }
    }
}

enum Rain {
    case moderate
    case lightDay
    case lightNight
    case heavy
    case drizzle
    
    var systemName: String {
        switch self {
        case .moderate:
            "cloud.rain.fill"
        case .lightDay:
            "cloud.sun.rain.fill"
        case .lightNight:
            "cloud.moon.rain.fill"
        case .heavy:
            "cloud.heavyrain.fill"
        case .drizzle:
            "cloud.drizzle.fill"
        }
    }
}

enum Thunderstorm {
    case moderate
    case rain
    
    var systemName: String {
        switch self {
        case .moderate:
            "cloud.bolt.fill"
        case .rain:
            "cloud.bolt.rain.fill"
        }
    }
}

enum Snow {
    case moderate
    case light
    case sleet
    
    var systemName: String {
        switch self {
        case .moderate:
            "snowflake"
        case .light:
            "cloud.snow.fill"
        case .sleet:
            "cloud.sleet.fill"
        }
    }
}

enum Atmosphere {
    case mist
    case fog
    case dustDay
    case dustNight
    case tornado
    
    var systemName: String {
        switch self {
        case .mist:
            "humidity.fill"
        case .fog:
            "cloud.fog.fill"
        case .dustDay:
            "sun.dust.fill"
        case .dustNight:
            "moon.dust.fill"
        case .tornado:
            "tornado"
        }
    }
}
