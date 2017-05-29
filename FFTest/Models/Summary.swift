//
//  Summary.swift
//  FFTest
//
//  Created by Francisco Amado on 29/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import Argo
import Curry
import Runes

protocol Summary {
    
    var name: String? { get set }               // The canonical name of the comic.
    var resourceURI: String? { get set }        // The canonical URL identifier for this resource.
    
    var pluralClassName: String { get }
}

