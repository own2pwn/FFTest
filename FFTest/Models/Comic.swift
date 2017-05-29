//
//  Comic.swift
//  FFTest
//
//  Created by Francisco Amado on 29/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import Argo
import Curry
import Runes

struct Comic: Summary {
    
    var name: String?
    var resourceURI: String?
    let pluralClassName: String = "Comics"
}

extension Comic: Decodable {
    
    static func decode(_ json: JSON) -> Decoded<Comic> {
        
        return curry(Comic.init)
            <^> json <|? "name"
            <*> json <|? "resourceURI"
    }
}
