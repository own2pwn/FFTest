//
//  UICollectionReusableView+Extension.swift
//  FFTest
//
// Utility extension for UICollectionReusableView
//
//  Created by Francisco Amado on 27/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit

extension UICollectionReusableView {
    
    static var nibName: String {
        
        return className(of: self)
    }
    
    static var reuseIdentifier: String {
        
        return className(of: self)
    }
}
