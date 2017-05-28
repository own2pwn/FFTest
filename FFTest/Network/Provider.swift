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
    
    func showIndicator() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideIndicator() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func fetchList(startingAt offset: Int, size limit: Int) -> Promise<[Hero]?> {
        
        showIndicator()
        
        let url = Endpoint.list(offset: offset, limit: limit).url()
        
        print("GET: \(url)")
        
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
    
    func fetchHero(_ id: Int) -> Promise<Hero?> {
        
        showIndicator()
        
        let url = Endpoint.hero(id: id).url()
        
        print("GET: \(url)")
        
        return network.GET(with: url)
            .then(execute: Parser.parse)
            .then { container in
                
                return container.results?.first
            }
            .catch { error in
                
                print("Error: \(error)")
            }
            .always(execute: hideIndicator)
    }
}
