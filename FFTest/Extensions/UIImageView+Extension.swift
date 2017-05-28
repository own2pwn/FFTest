//
//  UIImageView+Extension.swift
//  FFTest
//
//  Created by Francisco Amado on 28/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setAnimated(image: UIImage?, isFromMemoryCache: Bool) {
        
        // No transition when it's from memory cache
        guard !isFromMemoryCache else {
            self.image = image
            return
        }
        
        UIView.transition(with: self,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: { self.image = image })
    }
}
