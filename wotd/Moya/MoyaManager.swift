//
//  MoyaManager.swift
//  wotd
//
//  Created by EMILY on 06/09/2025.
//

import Foundation
import Alamofire
import Combine

/// NetworkManager tobe

class MoyaManager {
    static let shared = MoyaManager()
    
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
