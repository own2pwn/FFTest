//
//  File.swift
//  FFTest
//
//  Created by Francisco Amado on 27/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import Argo
import Curry
import Runes

struct Container {

    let offset: Int?                // The requested offset (number of skipped results) of the call.
    let limit: Int?                 // The requested result limit.
    let total: Int?                 // The total number of resources available given the current filter set.
    let count: Int?                 // The total number of results returned by this call.
    let results: [Hero]?            // The list of characters returned by the call.
}

extension Container: Decodable {
    
    static func decode(_ json: JSON) -> Decoded<Container> {
        
        return curry(Container.init)
            <^> json <|? "offset"
            <*> json <|? "limit"
            <*> json <|? "total"
            <*> json <|? "count"
            <*> json <||? "results"
    }
}

