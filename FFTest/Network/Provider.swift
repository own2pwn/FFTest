//
//  Provider.swift
//  FFTest
//
//  Created by Francisco Amado on 27/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit
import PromiseKit

class Provider {
    
    private let network: Network
    
    init(network: Network = Network()) {
        
        self.network = network
    }
    
    /// Syntax sugar for showing the System Network ActivityIndicator
    /// The provider itself is responsible for triggering the Network ActivityIndicator
    func showIndicator() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    /// Syntax sugar for hiding the System Network ActivityIndicator
    func hideIndicator() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    /// Fetch a limited Hero List, paginated with an offset
    ///
    /// - Parameters:
    ///   - offset: starting offset for the next elements
    ///   - limit: elements maximum range limit
    /// - Returns: Promise with a possible Hero Array
    func fetchList(startingAt offset: Int,
                   size limit: Int,
                   filtering string: String? = nil) -> Promise<[Hero]?> {
        
        showIndicator()
        
        let url = Endpoint.list(offset: offset, limit: limit, filter: string).url()
        
        print("GET: \(url)") // FIXME: Delete this before deploy
        
        return network.GET(with: url)
            .then(execute: Parser.parse)
            .then { container in
               
                return container.results
            }
            .catch { error in
                
                print("Error: \(error)")
            }
            .always(execute: hideIndicator)
    }
}
