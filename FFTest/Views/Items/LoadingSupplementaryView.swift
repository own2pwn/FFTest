//
//  LoadingSupplementaryView.swift
//  FFTest
//
//  Created by Francisco Amado on 29/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit
import Cartography

class LoadingSupplementaryView: UICollectionReusableView {
    
    static var preferredHeight: CGFloat {
        
        return 40
    }

    // MARK: - Properties
    
    fileprivate lazy var indicatorView: UIActivityIndicatorView = LoadingSupplementaryView.newIndicatorView()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        setup()
    }
    
    func startAnimating() {
        
        setNeedsLayout()
        layoutIfNeeded()
        indicatorView.startAnimating()
    }
    
    func stopAnimating() {
        
        guard indicatorView.isAnimating else { return }
            
        indicatorView.stopAnimating()
    }
    
    // MARK: - Private
    
    private func setup() {
        
        addSubview(indicatorView)
        
        constrain(self, indicatorView) { container, indicator in
            
            indicator.edges == container.edges
        }
        
        indicatorView.startAnimating()
    }
}

// MARK: - UI Components Factory
extension LoadingSupplementaryView {
    
    fileprivate class func newIndicatorView() -> UIActivityIndicatorView {
        
        return UIActivityIndicatorView(activityIndicatorStyle: .gray).tap {
            
            $0.color = Colors.brightGray
        }
    }
}
