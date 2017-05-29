//
//  Hero.swift
//  FFTest
//
//  Created by Francisco Amado on 27/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import Argo
import Curry
import Runes

struct Hero {
    
    let id: Int?                    // The unique ID of the character resource.,
    let name: String?               // The name of the character.
    let description: String?        // A short bio or description of the character.
    let modified: String?           // The date the resource was most recently modified.
    let resourceURI: String?        // The canonical URL identifier for this resource.
    let thumbnail: Image?           // The representative image for this character.
    let comics: [Comic]?            // A resource list containing comics which feature this character.
    let stories: [Story]?           // A resource list of stories in which this character appears.
    let events: [Event]?            // A resource list of events in which this character appears.
    let series: [Series]?           // A resource list of series in which this character appears.
//    let urls: [String]?             // A set of public web site URLs for the resource.

}

extension Hero: Decodable {
    
    static func decode(_ json: JSON) -> Decoded<Hero> {
        
        return curry(Hero.init)
            <^> json <|? "id"
            <*> json <|? "name"
            <*> json <|? "description"
            <*> json <|? "modified"
            <*> json <|? "resourceURI"
            <*> json <|? "thumbnail"
            <*> json <||? ["comics", "items"]
            <*> json <||? ["stories", "items"]
            <*> json <||? ["events", "items"]
            <*> json <||? ["series", "items"]
//            <*> json <||? "urls"
    }
}
