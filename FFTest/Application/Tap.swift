//
//  Tap.swift
//  FFTest
//
//  Created by Francisco Amado on 27/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import Foundation

/// Tap protocol
protocol Tap {}

/// Tap protocol extension
extension Tap {
    
    /// Provide alterations to a initialized object
    /// - parameter block: block with self object
    /// - returns: Self initialized object with changes
    func tap(_ block: (Self) -> Void ) -> Self {
        
        block(self)
        return self
    }
}

/// NSObject implementing Tap protocol
extension NSObject: Tap {}
