//
//  Request.swift
//  wotd
//
//  Created by EMILY on 11/12/2023.
//

import Foundation

struct Request {
    let urlComponent: String
    var params: [String: String]
    let header: [String: String]
    
    var queries: [URLQueryItem] {
        params.map { key, value in
            return URLQueryItem(name: key, value: value)
        }
    }
    
    var request: URLRequest {
        
        var url = URLComponents(string: urlComponent)!
        url.queryItems = queries
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"

        header.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }
    
    init(urlComponent: String, params: [String : String], header: [String : String] = [:]) {
        self.urlComponent = urlComponent
        self.params = params
        self.header = header
    }
}
