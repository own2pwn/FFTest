//
//  Story.swift
//  FFTest
//
//  Created by Francisco Amado on 29/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import Argo
import Curry
import Runes

struct Story: Summary {
    
    var name: String?
    var resourceURI: String?
    var type: String?
    let pluralClassName: String = "Stories"
}

extension Story: Decodable {
    
    static func decode(_ json: JSON) -> Decoded<Story> {
        
        return curry(Story.init)
            <^> json <|? "name"
            <*> json <|? "resourceURI"
            <*> json <|? "type"
    }
}
