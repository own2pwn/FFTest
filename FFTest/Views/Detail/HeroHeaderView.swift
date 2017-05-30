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
    let description: String?
    let image: URL?
    let backgroundImage: URL?
    
    var isDescriptionEmpty: Bool {
        
        if let description = description {
            return description.isEmpty
        }
        
        return true
    }
}

class HeroHeaderView: UIView {
    
    // MARK: - Properties
    
    class var preferredHeight: CGFloat {
        
        return 64
    }
    
    fileprivate var configuration: HeroHeaderViewConfiguration
    fileprivate var blurView: UIVisualEffectView?
    fileprivate lazy var label: UILabel = HeroHeaderView.newLabel()
    fileprivate lazy var backgroundView: LoadingImageView = HeroHeaderView.newLoadingImageView()

    // MARK: Constants
    
    fileprivate static var spacing: CGFloat = 8
    fileprivate static var minimumVerticalInset: CGFloat = 64
    fileprivate static var labelFont: UIFont = UIFont.boldSystemFont(ofSize: 18)
    
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
    
    /// Calculates the preferred Height to fit HeroHeaderView on a given width.
    /// This takes into account the description text to be presented.
    ///
    /// - Parameter width: container width
    /// - Returns: estimated height for width or **HeroHeaderView.preferredHeight**
    func preferredHeight(for width: CGFloat) -> CGFloat {
        
        guard let description = configuration.description,
            description.isEmpty == false else {
            
            return HeroHeaderView.preferredHeight
        }
        
        var height: CGFloat = 0
        
        // Description Height calculation
        height += HeroHeaderView.minimumVerticalInset
        
        let maxWidth = width - HeroHeaderView.spacing * 2
        
        height += ceil(HeroHeaderView.labelFont.ascender)
        
        height += NSAttributedString(string: description, attributes: [
                NSFontAttributeName: HeroHeaderView.labelFont
            ])
            .boundingHeight(with: maxWidth)
        
        height += ceil(HeroHeaderView.labelFont.descender)
        height += HeroHeaderView.spacing * 2
        
        return height
    }

    // MARK: - Private
    
    private func setup() {
        
        addSubviews()
        addConstraints()
        
        configure(text: configuration.description)
        configure(background: configuration.image)
    }
    
    private func addSubviews() {
        
        addSubview(backgroundView)
        addSubview(label)
        
        guard UIAccessibilityIsReduceTransparencyEnabled() == false else {
            
            return
        }
        
        blurView = HeroHeaderView.newBlurView(frame: backgroundView.bounds)
        
        guard let blurView = blurView else { return }
        
        addSubview(blurView)
    }
    
    private func addConstraints() {
        
        // Set label z position to always be on top
        bringSubview(toFront: label)
        
        constrain(self, backgroundView) { container, background in
            
            background.edges == container.edges
        }
        
        constrain(self, label) { container, content in
            
            content.bottom == container.bottom - HeroHeaderView.spacing
            content.leading == container.leading + HeroHeaderView.spacing
            content.trailing == container.trailing - HeroHeaderView.spacing
        }
        
        guard let blurView = blurView else { return }
        
        constrain(self, blurView) { container, blur in
            
            blur.edges == container.edges
        }
    }
    
    private func configure(text: String?) {
        
        label.text = text
    }
    
    private func configure(background: URL?) {
        
        backgroundView.configure(with: background)
    }
}

// MARK: - HeroHeaderView Components Factory
extension HeroHeaderView {
    
    fileprivate final class func newLabel() -> UILabel {
        
        return UILabel().tap {
            
            $0.font = UIFont.boldSystemFont(ofSize: 18)
            $0.textColor = Colors.white
            $0.isOpaque = false
            $0.backgroundColor = Colors.clear
            $0.textAlignment = NSTextAlignment.center
            $0.numberOfLines = 0
            
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
    
    fileprivate final class func newBlurView(frame: CGRect) -> UIVisualEffectView {
        
        let effectView = UIVisualEffectView(effect:
            UIBlurEffect(style: UIBlurEffectStyle.dark)
        )
        
        effectView.frame = frame
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return effectView
    }
}
