//
//  NetworkError.swift
//  wotd
//
//  Created by EMILY on 22/09/2025.
//

import Foundation
import Moya

enum NetworkError: Error {
    case moyaError(MoyaError)
    case decodingError
    case noData
    case unknown(Error)
    
    var errorMessage: LocalizedStringResource {
        switch self {
        case .moyaError(let error):
            return "[NetworkError] Moya error occured: \(error.localizedDescription)"
        case .decodingError:
            return "[NetworkError] Decoding error occured"
        case .noData:
            return "[NetworkError] no data"
        case .unknown(let error):
            return "[NetworkError] >>> \(error.localizedDescription)"
        }
    }
}
