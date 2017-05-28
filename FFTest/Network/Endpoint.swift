//
//  Endpoint.swift
//  FFTest
//
//  Created by Francisco Amado on 28/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import Foundation

/// Endpoints enum.
/// Provide an Endpoint access for connecting to Marvel API
enum Endpoint {
    
    case list(offset: Int, limit: Int)
    case hero(id: Int)
}

extension Endpoint {
    
    fileprivate var path: String {
        
        switch self {
            
        case let .list(offset, limit):
            return "/characters?orderBy=-modified&limit=\(limit)&offset=\(offset)"
            
        case let .hero(id):
            return "/characters/\(id)?"
        }
    }
}

extension Endpoint {
    
    private var baseURL: String {
        
        return "https://gateway.marvel.com"
    }
    
    private var version: String {
        
        return "/v1/public"
    }
    
    /// Get full URL for path
    /// - returns: Full URL for path
    func url() -> URL {
        
        guard let credentials = Encrypt().credentials() else {
            
            fatalError("Failed to encrypt credentials")
        }
        
        let timestamp = "&ts=\(credentials.ts)"
        let apiKey = "&apikey=\(credentials.key)"
        let hash = "&hash=\(credentials.hash)"
        
        return URL(string: baseURL + version + path + timestamp + apiKey + hash)!
    }
}
