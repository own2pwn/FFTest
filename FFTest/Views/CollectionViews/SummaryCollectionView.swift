//
//  SummaryCollectionView.swift
//  FFTest
//
//  Created by Francisco Amado on 29/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit

class SummaryCollectionView: UICollectionView {
    
    init(frame: CGRect = CGRect.zero) {
        
        let layout = UICollectionViewFlowLayout().tap {
            
            $0.minimumInteritemSpacing = 0
            $0.minimumLineSpacing = 8
            $0.sectionHeadersPinToVisibleBounds = true
        }
        
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        backgroundColor = Colors.charcoalGrey
        register(class: SummaryCell.self)
        register(forSectionHeader: SummaryHeaderView.self)
    }
}
