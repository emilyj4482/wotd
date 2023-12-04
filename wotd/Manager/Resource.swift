//
//  Resource.swift
//  wotd
//
//  Created by EMILY on 04/12/2023.
//

import Foundation

struct Resource<T: Decodable> {
    var urlComponent: String
    var params: [String: String]
    var header: [String: String]

    var urlRequest: URLRequest? {
        
        // query를 제외한 url
        var url = URLComponents(string: urlComponent)
        
        // query
        let queryItems = params.map { (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        }
        url?.queryItems = queryItems
        
        // request URL
        guard let requestURL = url?.url else { return nil }
        
        // request
        var request = URLRequest(url: requestURL)
        
        // request method
        request.httpMethod = "GET"
        
        // header
        header.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}
