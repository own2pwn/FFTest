//
//  Event.swift
//  FFTest
//
//  Created by Francisco Amado on 29/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import Argo
import Curry
import Runes

struct Event: Summary {
    
    var name: String?
    var resourceURI: String?
    let pluralClassName: String = "Events"
}

extension Event: Decodable {
    
    static func decode(_ json: JSON) -> Decoded<Event> {
        
        return curry(Event.init)
            <^> json <|? "name"
            <*> json <|? "resourceURI"
    }
}
