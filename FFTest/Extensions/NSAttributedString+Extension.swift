//
//  NSAttributedString+Extension.swift
//  FFTest
//
//  Created by Francisco Amado on 29/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    /// Calculates and returns the bounding height for a given width
    ///
    /// - Parameter width: constraining width for the view rect
    /// - Returns: calculated bounding height
    func boundingHeight(with width: CGFloat) -> CGFloat {
        
        return boundingHeight(for:
            CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        )
    }
    
    private func boundingHeight(for size: CGSize) -> CGFloat {
        
        return boundingRect(with: size,
                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                            context: nil).height
    }
}
