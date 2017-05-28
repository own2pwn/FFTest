//
//  Network.swift
//  FFTest
//
//  Created by Francisco Amado on 27/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import Foundation
import PromiseKit

class Network {
    
    fileprivate let session: URLSession
    
    init(_ session: URLSession = URLSession(configuration: Network.configuration)) {
        
        self.session = session
    }
    
    private static let configuration = URLSessionConfiguration.default
}

// MARK: - Requests
extension Network {
    
    /// Wrapper around URLSession.dataTask for handling Network calls with Promises
    ///
    /// - Parameter url: valid URL for requesting data from
    /// - Returns: a Promise with a valid Response Object
    func GET(with url: URL) -> Promise<Data> {
        
        return Promise { fulfill, reject in
            
            let dataTask = session.dataTask(with: url) { data, response, error in
                
                switch (data, error) {
                case let (data?, _):
                    fulfill(data)
                case let (_, error?):
                    reject(error)
                default:
                    print("NOTHING FOUND IN GET(with url)")
                    reject(error!)
                }
            }
            
            dataTask.resume()
        }
    }
}
