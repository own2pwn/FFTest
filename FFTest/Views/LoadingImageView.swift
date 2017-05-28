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
import PromiseKit

fileprivate enum LoadingState {
    
    case loading
    case error
    case success
}

final class LoadingImageView: UIImageView {
    
    // MARK: - Properties
    
    fileprivate var url: URL?
    fileprivate lazy var errorLabel = LoadingImageView.newErrorLabel()
    fileprivate lazy var activityIndicatorView = LoadingImageView.newIndicatorView()
    
    fileprivate var state: LoadingState = .loading {
        
        didSet {
            
            switch  state {
                
            case .loading:
//                errorLabel.isHidden = true
                activityIndicatorView.startAnimating()
                
            case .error:
//                errorLabel.isHidden = false
                activityIndicatorView.stopAnimating()
                
            case .success:
//                errorLabel.isHidden = true
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
        
//        if !errorLabel.isHidden {
//            
//            errorLabel.sizeToFit()
//        }
        
        if !activityIndicatorView.isHidden {
            
            activityIndicatorView.sizeToFit()
            activityIndicatorView.center = center
        }
    }
    
    
    func configure(with url: URL?) -> Promise<Void> {
        
        self.url = url
        state = .loading
        image = nil
        
        guard let url = url else {
            
            state = .error
            return Promise(error: CustomError.empty)
        }
        
        return Promise { fullfil, reject in
            
            let request = Nuke.Request(url: url)
            
            Nuke.loadImage(with: request, into: self) {
                [weak self] response, isFromMemoryCache in
                
                switch response {
                    
                case let .success(image):
                    self?.state = .success
                    self?.setAnimated(image: image,
                                      isFromMemoryCache: isFromMemoryCache)
                    fullfil()
                    
                default:
                    self?.state = .error
                    reject(CustomError.networking)
                }
            }
        }
    }
    
    // MARK: - Private
    
    fileprivate func setup() {
        
//        addSubview(errorLabel)
        addSubview(activityIndicatorView)
    }
}

// MARK: - UI Components Factory
extension LoadingImageView {

    fileprivate class func newErrorLabel() -> UILabel {
        
        return UILabel().tap {

            $0.textAlignment = .center
            $0.numberOfLines = 1
            $0.isHidden = true
            $0.text = "ERROR"
        }
    }
    
    fileprivate class func newIndicatorView() -> UIActivityIndicatorView {
        
        return UIActivityIndicatorView(activityIndicatorStyle: .gray).tap {
            
            $0.color = Colors.charcoalGrey
        }
    }
}
