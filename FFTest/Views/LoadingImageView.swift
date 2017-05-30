//
//  LoadingImageView.swift
//  FFTest
//
//  Created by Francisco Amado on 28/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit
import Cartography
import Nuke

fileprivate enum LoadingState {
    
    case loading
    case error
    case success
}

final class LoadingImageView: UIImageView {
    
    // MARK: - Properties
    
    fileprivate var url: URL?
    fileprivate lazy var activityIndicatorView = LoadingImageView.newIndicatorView()
    
    fileprivate var state: LoadingState = .loading {
        
        didSet {
            
            switch  state {
                
            case .loading:
                activityIndicatorView.startAnimating()
                
            case .error:
                activityIndicatorView.stopAnimating()
                
            case .success:
                activityIndicatorView.stopAnimating()
            }
            
            setNeedsLayout()
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
    }
    
    override init(image: UIImage?) {
        
        super.init(image: image)
        setup()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        
        super.init(image: image, highlightedImage: highlightedImage)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if !activityIndicatorView.isHidden {
            
            activityIndicatorView.sizeToFit()
            activityIndicatorView.center = center
        }
    }
    
    
    func configure(with url: URL?) {
        
        self.url = url
        state = .loading
        image = nil
        
        guard let url = url else {
            
            state = .error
            return
        }
        
        let request = Nuke.Request(url: url)
        
        Nuke.loadImage(with: request, into: self) {
            [weak self] response, isFromMemoryCache in
            
            switch response {
                
            case let .success(image):
                self?.state = .success
                self?.setAnimated(image: image,
                                  isFromMemoryCache: isFromMemoryCache)
                
            default:
                self?.state = .error
            }
        }
    }
    
    // MARK: - Private
    
    fileprivate func setup() {
        
        addSubview(activityIndicatorView)
    }
}

// MARK: - UI Components Factory
extension LoadingImageView {
    
    fileprivate class func newIndicatorView() -> UIActivityIndicatorView {
        
        return UIActivityIndicatorView(activityIndicatorStyle: .gray).tap {
            
            $0.color = Colors.charcoalGrey
        }
    }
}
