//
//  HeroCollectionViewController.swift
//  FFTest
//
//  Created by Francisco Amado on 28/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit
import PromiseKit
import Cartography

class HeroCollectionViewController: UIViewController {
    
    fileprivate let provider: Provider
    fileprivate var offset: Int = 0
    fileprivate let limit: Int = 20
    
    fileprivate var list: [Hero]? = [] {
        
        didSet {
            collectionView.reloadData()
            isLoading = false
        }
    }
    
    fileprivate var isLoading: Bool = true {
        didSet {
            if isLoading {
                loadingView?.startAnimating()
            } else{
                loadingView?.stopAnimating()
            }
        }
    }
    
    fileprivate var loadingView: LoadingSupplementaryView?
    fileprivate(set) lazy var collectionView: HeroCollectionView = HeroCollectionViewController.newCollectionView()
    
    init(with provider: Provider = Provider()) {
        
        self.provider = provider
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = "MARVEL"
        
        addSubviews()
        configureEdges()
        layout()
        loadInitial()
    }
    
    private func addSubviews() {
        
        //        view.addSubview(emptyStateView)
        //        view.addSubview(errorStateView)
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
        
        view.backgroundColor = UIColor.darkGray
    }
}

// MARK: - UI Extension
extension HeroCollectionViewController {
    
    fileprivate final class func newCollectionView() -> HeroCollectionView {
        
        return HeroCollectionView()
    }
}

extension HeroCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let hero: Hero? = list?[indexPath.row]
        let configuration = HeroCellConfiguration(title: hero?.name,
                                                  image: hero?.thumbnail?.asURL)
        
        return collectionView.dequeue(cell: HeroCell.self,
                                      forIndexPath: indexPath).tap {
                                        
                                        $0.configure(configuration)
                                        $0.layer.shouldRasterize = true
                                        $0.layer.rasterizationScale = UIScreen.main.scale
                                        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        loadingView = collectionView.dequeueSection(footer: LoadingSupplementaryView.self,
                                                    forIndexPath: indexPath)
        
        loadingView?.layoutIfNeeded()
        
        return loadingView!
    }
    
    // MARK: Loading Elements
    
    /// Loads initial batch of Heros
    fileprivate func loadInitial() {
        
        print("LOAD INITIAL")
        
        _ = provider.fetchList(startingAt: offset, size: limit)
            .then { list in
                
                self.list = list
            }
    }
    
    /// Loads next batch of Heros, offsetted by the current count or an estimated value
    fileprivate func loadMore() {
        
        guard isLoading == false else { return }
        
        print("LOAD MORE")
        
        isLoading = true
        
        offset = list?.count ?? offset + limit
        
        _ = provider.fetchList(startingAt: offset, size: limit)
            .then(execute: add)
    }
    
    /// Add the newly fetched Hero list to the existing one
    ///
    /// - Parameter list: fetched Hero List
    fileprivate func add(list: [Hero]?) {
        
        guard let old = self.list, let new = list
            else { return }
        
        self.list = old + new
    }
}

extension HeroCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Items should maintain a ratio of 1:1 for complying
        // with the provided images from Marvel API
        let maxWidth = collectionView.bounds.width / 2
        return CGSize(width: maxWidth, height: maxWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        
        guard let list = list, list.isEmpty == false else {
            
            return CGSize(width: collectionView.bounds.width,
                          height: collectionView.bounds.height)

        }
        
        return CGSize(width: collectionView.bounds.width,
                      height: LoadingSupplementaryView.preferredHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // Load More when its two rows to the end
        if collectionView.isAtBottom(offset: collectionView.bounds.width) {
            
            loadMore()
        }
    }
}
