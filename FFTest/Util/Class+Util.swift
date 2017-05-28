//
//  Class+Util.swift
//  FFTest
//
//  Created by Francisco Amado on 27/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import Foundation

/// Helper method for getting the class name, as a String, of a given class
///
/// - Parameter aClass: AnyClass to know the name
/// - Returns: String name of the class separatedBy '.'
func className(of aClass: AnyClass) -> String {
    
    return "\(aClass)".components(separatedBy: ".").last!
}
