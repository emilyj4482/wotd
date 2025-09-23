//
//  NetworkManager.swift
//  wotd
//
//  Created by EMILY on 04/12/2023.
//  Refactored by EMILY on 06/09/2025.

import Foundation
import Alamofire
import Combine

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        return Future<T, Error> { promise in
            AF.request(url).responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    promise(.success(value))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
