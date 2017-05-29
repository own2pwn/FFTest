//
//  SummaryHeaderView.swift
//  FFTest
//
//  Created by Francisco Amado on 29/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit
import Cartography

class SummaryHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    
    class var preferredHeight: CGFloat {
        
        return 30
    }
    
    fileprivate lazy var label: UILabel = SummaryHeaderView.newLabel()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String?) {
        
        defer { setNeedsLayout() }
        
        label.text = text
        label.sizeToFit()
    }
    
    // MARK: - Private
    
    private func setup() {
        
        isOpaque = true
        backgroundColor = Colors.brightGray
        
        addSubview(label)
        
        constrain(self, label) { container, content in
            
            content.edges == inset(container.edges, SummaryHeaderView.spacing)
        }
    }
    
    fileprivate static let spacing: CGFloat = 8
}

// MARK: - UI Components Factory
extension SummaryHeaderView {

    fileprivate class func newLabel() -> UILabel {
        
        return UILabel().tap {
            
            $0.font = UIFont.boldSystemFont(ofSize: 16)
            $0.textColor = Colors.charcoalGrey
        }
    }
}
