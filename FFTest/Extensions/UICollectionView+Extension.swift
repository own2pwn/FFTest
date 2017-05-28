//
//  UICollectionView+Extension.swift
//  FFTest
//
//  Created by Francisco Amado on 27/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit

// Utility extension for UICollectionView
extension UICollectionView {
    
    func register<T: UICollectionViewCell>(class cls: T.Type) {
        
        register(cls, forCellWithReuseIdentifier: cls.reuseIdentifier)
    }
    
    func register<T: UICollectionReusableView>(class cls: T.Type, forSupplementaryViewOfKind elementKind: String) {
        
        register(cls, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: cls.reuseIdentifier)
    }
    
    func register<T: UICollectionReusableView>(forSectionHeader cls: T.Type) {
        
        register(class: cls, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader)
    }
    
    func register<T: UICollectionReusableView>(forSectionFooter cls: T.Type) {
        
        register(class: cls, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter)
    }
    
    func dequeue<T: UICollectionViewCell>(cell cls: T.Type, forIndexPath indexPath: IndexPath) -> T {
        
        return dequeueReusableCell(withReuseIdentifier: cls.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueSupplementaryView<T: UICollectionReusableView>(_ cls: T.Type,
                                  ofKind kind: String,
                                  forIndexPath indexPath: IndexPath) -> T {
        
        return dequeueReusableSupplementaryView(ofKind: kind,
                                                withReuseIdentifier: T.reuseIdentifier,
                                                for: indexPath) as! T
    }
    
    func dequeueSection<T: UICollectionReusableView>(header cls: T.Type, forIndexPath indexPath: IndexPath) -> T {
        
        return dequeueSupplementaryView(cls, ofKind: UICollectionElementKindSectionHeader, forIndexPath: indexPath)
    }
    
    func dequeueSection<T: UICollectionReusableView>(footer cls: T.Type, forIndexPath indexPath: IndexPath) -> T {
        
        return dequeueSupplementaryView(cls, ofKind: UICollectionElementKindSectionFooter, forIndexPath: indexPath)
    }
    
    /// Scroll the collection view to the top offset
    ///
    /// - Parameter animated: defaults to false
    func scrollToTop(animated: Bool = false) {
        
        setContentOffset(CGPoint(x: 0.0, y: -contentInset.top), animated: animated)
    }
}
