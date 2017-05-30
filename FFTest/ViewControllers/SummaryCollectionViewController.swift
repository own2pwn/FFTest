//
//  SummaryCollectionViewController.swift
//  FFTest
//
//  Created by Francisco Amado on 29/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit
import PromiseKit
import Cartography

typealias SummarySection = (name: String?, summaries: [Summary]?)

class SummaryCollectionViewController: UIViewController {
    
    fileprivate var list: [SummarySection] = [] {
        
        didSet { collectionView.reloadData() }
    }
    
    fileprivate(set) lazy var collectionView = SummaryCollectionViewController.newCollectionView()
    
    init(with nestedList: [SummarySection]) {
        
        self.list = nestedList
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addSubviews()
        configureEdges()
        layout()
    }
    
    private func addSubviews() {
        
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func configureEdges() {
        
        constrain(view, collectionView) { container, collection in
            
            collection.edges == container.edges
        }
    }
    
    private func layout() {
        
        view.backgroundColor = Colors.charcoalGrey
    }
}

// MARK: - UI Components Factory
extension SummaryCollectionViewController {
    
    fileprivate class func newCollectionView() -> SummaryCollectionView {
        
        return SummaryCollectionView()
    }
}

// MARK: - UICollectionViewDataSource
extension SummaryCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        guard let count = list[section].summaries?.count else {
        
            return 0
        }
        
        return count > 3 ? 3 : count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let summary: Summary? = list[indexPath.section].summaries?[indexPath.row]
        
        return collectionView.dequeue(cell: SummaryCell.self,
                                      forIndexPath: indexPath).tap {
                                        
                                        $0.configure(with: summary?.name)
                                        $0.layer.shouldRasterize = true
                                        $0.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        let name: String? = list[indexPath.section].name

        return collectionView.dequeueSection(header: SummaryHeaderView.self,
                                             forIndexPath: indexPath).tap {
                                                
                                        $0.configure(text: name)
        }
    }
}

extension SummaryCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxWidth = collectionView.bounds.width
        return CGSize(width: maxWidth, height: SummaryCell.preferredHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {

        return CGSize(width: collectionView.bounds.width,
                      height: SummaryHeaderView.preferredHeight)
    }
}
