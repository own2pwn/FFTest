//
//  CustomError.swift
//  FFTest
//
//  Created by Francisco Amado on 28/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import Foundation
import PromiseKit
import Argo

/// CustomError enum
/// Implemets Error and Equatable
enum CustomError: Error {
    
    case networking
    case timeout
    case parsing(error: DecodeError?)
    case empty
    case unknown
}

extension CustomError: Equatable {
    
    static func == (lhs: CustomError, rhs: CustomError) -> Bool {
        
        switch (lhs, rhs) {
            
        case (.networking, .networking),
             (.timeout, .timeout),
             (.parsing, .parsing),
             (.empty, .empty),
             (.unknown, .unknown):
            return true
            
        default:
            return false;
        }
    }
}
