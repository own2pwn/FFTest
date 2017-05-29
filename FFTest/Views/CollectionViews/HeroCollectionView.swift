//
//  HeroCollectionView.swift
//  FFTest
//
//  Created by Francisco Amado on 28/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit

class HeroCollectionView: UICollectionView {
    
    init(frame: CGRect = CGRect.zero) {
        
        let layout = UICollectionViewFlowLayout().tap {
            
            $0.minimumInteritemSpacing = 0
            $0.minimumLineSpacing = 0
        }
        
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        backgroundColor = Colors.charcoalGrey
        register(class: HeroCell.self)
        register(forSectionFooter: LoadingSupplementaryView.self)
    }
}

extension HeroCollectionView {
    
    func isAtBottom(offset: CGFloat = 0.0) -> Bool {
        
        let bottomVerticalOffset = contentSize.height + contentInset.bottom - bounds.height
        
        return contentOffset.y >= bottomVerticalOffset - offset
    }
}
