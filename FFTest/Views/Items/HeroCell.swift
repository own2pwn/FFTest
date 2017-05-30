//
//  HeroCell.swift
//  FFTest
//
//  Created by Francisco Amado on 28/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit
import Cartography
import Nuke

struct HeroCellConfiguration {
    
    let title: String?
    let image: URL?
}

class HeroCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    fileprivate lazy var label: UILabel = HeroCell.newLabel()
    fileprivate lazy var overlay: UIView = HeroCell.newLayerView()
    fileprivate lazy var imageView: LoadingImageView = HeroCell.newLoadingImageView()
    
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
    
    func configure(_ configuration: HeroCellConfiguration) {
        
        defer { setNeedsLayout() }
        
        configure(label: configuration.title)
        configure(image: configuration.image)
    }
    
    // MARK: - Private
    
    private func setup() {
        
        isOpaque = false
        contentView.isOpaque = false
        backgroundColor = Colors.clear
        
        addSubviews()
        addContrains()
    }
    
    private func configure(label content: String?) {
        
        label.text = content
    }
    
    private func configure(image url: URL?) {
        
        imageView.configure(with: url)
    }
    
    private func addSubviews() {
        
        contentView.addSubview(imageView)
        contentView.addSubview(overlay)
        contentView.addSubview(label)
    }
    
    private func addContrains() {
        
        constrain(contentView, imageView, label, overlay) {
            container, background, content, layered in
            
            background.leading == container.leading + HeroCell.spacing
            background.trailing == container.trailing - HeroCell.spacing
            background.top == container.top + HeroCell.spacing
            background.bottom == container.bottom - HeroCell.spacing
            
            content.bottom == container.bottom - HeroCell.spacing
            content.leading == container.leading + HeroCell.spacing
            content.trailing == container.trailing - HeroCell.spacing
            
            layered.top == content.top
            layered.bottom == content.bottom
            layered.leading == content.leading
            layered.trailing == content.trailing
        }
    }
    
    private static let spacing: CGFloat = 8
}

// MARK: - HeroCell Components Factory
extension HeroCell {

    fileprivate final class func newLabel() -> UILabel {
        
        return UILabel().tap {
            
            $0.font = UIFont.boldSystemFont(ofSize: 16)
            $0.textColor = Colors.white
            $0.isOpaque = false
            $0.backgroundColor = Colors.clear
            $0.textAlignment = NSTextAlignment.center
            $0.numberOfLines = 0
            
            $0.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow,
                                                       for: .horizontal)
        }
    }
    
    fileprivate final class func newLayerView() -> UIView {
        
        return UIView().tap {
            
            $0.backgroundColor = Colors.brightGray.withAlphaComponent(0.4)
        }
    }
    
    fileprivate final class func newLoadingImageView() -> LoadingImageView {
        
        return LoadingImageView().tap {
            
            $0.isOpaque = true
            $0.backgroundColor = Colors.brightGray
            $0.layer.cornerRadius = 4
            $0.layer.masksToBounds = true
        }
    }
}

