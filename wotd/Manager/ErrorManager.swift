//
//  ErrorManager.swift
//  wotd
//
//  Created by EMILY on 26/01/2024.
//

import Foundation

enum NetworkError: LocalizedError {
    case custom(error: Error)
    case failedToDecode
    case invalideStatusCode
    
    var errorDescription: String? {
        switch self {
        case .failedToDecode:
            return "[ERROR] failed to decode response"
        case .invalideStatusCode:
            return "[ERROR] request falls within an invalid range"
        case .custom(let error):
            return "[ERROR] \(error.localizedDescription)"
        }
    }
}

struct ErrorMessage: Decodable {
    let message: String
}

struct ErrorMessage2: Decodable {
    let msg: String
}
