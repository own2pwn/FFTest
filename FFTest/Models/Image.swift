//
//  Image.swift
//  FFTest
//
//  Created by Francisco Amado on 27/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import Argo
import Curry
import Runes

struct Image {
    
    let path: String?               // The directory path of to the image.
    let fileExtension: String?      // The file extension for the image.
    
    var asURL: URL? {
        
        guard let path = path, let fileExtension = fileExtension else {
            
            return nil
        }
        
        let ssPath = (path as NSString).replacingOccurrences(of: "http", with: "https")
        
        return URL(string: ssPath + "." + fileExtension)
    }
}

extension Image: Decodable {
    
    static func decode(_ json: JSON) -> Decoded<Image> {
        
        return curry(Image.init)
            <^> json <|? "path"
            <*> json <|? "extension"
    }
}
