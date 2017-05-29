//
//  Series.swift
//  FFTest
//
//  Created by Francisco Amado on 29/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import Argo
import Curry
import Runes

struct Series: Summary {
    
    var name: String?
    var resourceURI: String?
    let pluralClassName: String = "Series"
}

extension Series: Decodable {
    
    static func decode(_ json: JSON) -> Decoded<Series> {
        
        return curry(Series.init)
            <^> json <|? "name"
            <*> json <|? "resourceURI"
    }
}
