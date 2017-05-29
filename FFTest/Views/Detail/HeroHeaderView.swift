//
//  HeroHeaderView.swift
//  FFTest
//
//  Created by Francisco Amado on 29/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit
import Cartography

struct HeroHeaderViewConfiguration {
    
    let title: String?
    let image: URL?
}

class HeroHeaderView: UIView {
    
    // MARK: - Properties
    
    class var preferredHeight: CGFloat {
        
        return 220
    }
    
    fileprivate var configuration: HeroHeaderViewConfiguration
    fileprivate lazy var label: UILabel = HeroHeaderView.newLabel()
    fileprivate lazy var imageView: LoadingImageView = HeroHeaderView.newLoadingImageView()
    
    // MARK: - Lifecycle
    
    init(with configuration: HeroHeaderViewConfiguration,
         frame: CGRect = CGRect.zero) {
        
        self.configuration = configuration
        
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        addSubviews()
        addConstraints()
        
        configure(title: configuration.title)
        configure(image: configuration.image)
    }
    
    private func addSubviews() {
        
        addSubview(imageView)
//        addSubview(label)
    }
    
    private func addConstraints() {
        
        constrain(self, imageView) { container, avatar in
            
            avatar.edges == container.edges
        }
    }
    
    private func configure(title: String?) {
        
        label.text = title?.uppercased()
    }
    
    private func configure(image: URL?) {
        
        _ = imageView.configure(with: image)
    }
}

// MARK: - HeroHeaderView Components Factory
extension HeroHeaderView {
    
    fileprivate final class func newLabel() -> UILabel {
        
        return UILabel().tap {
            
            $0.font = UIFont.boldSystemFont(ofSize: 24)
            $0.textColor = Colors.white
            $0.isOpaque = false
            $0.backgroundColor = Colors.clear
            $0.textAlignment = NSTextAlignment.center
            
            $0.setContentCompressionResistancePriority(UILayoutPriorityDefaultLow,
                                                       for: .horizontal)
        }
    }
    
    fileprivate final class func newLoadingImageView() -> LoadingImageView {
        
        return LoadingImageView().tap {
            
            $0.isOpaque = true
            $0.backgroundColor = Colors.brightGray
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
        }
    }
}
