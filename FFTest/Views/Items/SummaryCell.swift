//
//  SummaryCell.swift
//  FFTest
//
//  Created by Francisco Amado on 29/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit
import Cartography
import Nuke

class SummaryCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    class var preferredHeight: CGFloat {
        
        return 60
    }
    
    fileprivate lazy var label: UILabel = SummaryCell.newLabel()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
    }
    
    func configure(with title: String?) {
        
        defer { setNeedsLayout() }
        
        configure(label: title)
    }
    
    // MARK: - Private
    
    private func setup() {
        
        isOpaque = false
        contentView.isOpaque = false
        backgroundColor = SummaryCell.defaultColor
        
        addSubviews()
        addContrains()
    }
    
    private func addSubviews() {
        
        contentView.addSubview(label)
    }
    
    private func addContrains() {
        
        constrain(contentView, label) { container, content in
            
            content.edges == inset(container.edges, SummaryCell.spacing)
        }
    }
    
    private func configure(label content: String?) {
        
        label.text = content
    }
    
    private static let spacing: CGFloat = 16
    fileprivate static let defaultColor: UIColor = Colors.charcoalGrey
}

// MARK: - SummaryCell Components Factory
extension SummaryCell {
    
    fileprivate final class func newLabel() -> UILabel {
        
        return UILabel().tap {
            
            $0.font = UIFont.boldSystemFont(ofSize: 16)
            $0.textColor = Colors.white
            $0.isOpaque = true
            $0.backgroundColor = SummaryCell.defaultColor
            $0.textAlignment = NSTextAlignment.right
            $0.numberOfLines = 1
            
            $0.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow,
                                                       for: .horizontal)
        }
    }
}

