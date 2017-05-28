//
//  Response.swift
//  FFTest
//
//  Created by Francisco Amado on 27/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import Argo
import Curry
import Runes

struct Response {
    
    let code: Int?                  // The HTTP status code of the returned result.
    let status: String?             // description of the call status.,
    let data: Container?            // The results returned by the call.,
//    let attributionText: String?
//    let attributionHTML: String?
}

extension Response: Decodable {
    
    static func decode(_ json: JSON) -> Decoded<Response> {
        
        return curry(Response.init)
            <^> json <|? "code"
            <*> json <|? "status"
            <*> json <|? "data"
    }
}
