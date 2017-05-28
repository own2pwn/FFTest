//
//  Parser.swift
//  FFTest
//
//  Created by Francisco Amado on 27/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import PromiseKit
import Argo

class Parser {
    
    /// Parser helper function for using Promises
    /// - parameter data: Data fetched from the Marvel API
    /// - returns: Promise with the parsed Decodable value
    class func parse(_ data: Data) -> Promise<Container> {
        
        return Promise { fulfill, reject in
            
            let json = try JSONSerialization.jsonObject(with: data, options: []) as AnyObject
            let decoded: Decoded<Response> = Response.decode(JSON(json))
            
            guard let value: Container = decoded.value?.data else {
                
                print(json)
                
                reject(CustomError.parsing(error: decoded.error))
                return
            }
            
            fulfill(value)
        }
    }
}
