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
    
    /// Filter CollectionView content with String
    /// Setting this property will trigger the content refresh
    var filter: String? {
        didSet{ loadInitial(filtering: filter) }
    }
    
    fileprivate let provider: Provider
    fileprivate var offset: Int = 0
    fileprivate let limit: Int = 20
    
    fileprivate var list: [Hero]? = [] {
        didSet {
            collectionView.reloadData()
            isLoading = list?.isEmpty ?? true
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

// MARK: - Previewing Helpers
extension HeroCollectionViewController {
    
    func previewingViewController(at position: CGPoint) -> UIViewController? {
        
        guard let indexPath = collectionView.indexPathForItem(at: position)
            else { return nil }

        guard let hero = list?[indexPath.row] else { return nil }
        
        return HeroDetailViewController(with: hero)
    }
    
    func cellRect(at position: CGPoint) -> CGRect {
        
        if let indexPath = collectionView.indexPathForItem(at: position),
            let cell = collectionView.cellForItem(at: indexPath) {
            
            return cell.frame
        }
        
        // Return a default estimate for the cell CGRect
        return CGRect(x: view.center.x,
                      y: position.y,
                      width: collectionView.bounds.width / 2,
                      height: collectionView.bounds.width / 2)
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
    
    /// Loads initial batch of Heroes
    fileprivate func loadInitial(filtering string: String? = nil) {
        
        self.list = nil
                
        _ = provider.fetchList(startingAt: offset, size: limit, filtering: string)
            .then { list in
                
                self.list = list
            }
    }
    
    /// Loads next batch of Heroes, offsetted by the current count or an estimated value
    fileprivate func loadMore() {
        
        guard isLoading == false else { return }
        
        isLoading = true
        
        offset = list?.count ?? offset + limit
        
        _ = provider.fetchList(startingAt: offset, size: limit, filtering: filter)
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
    
    // MARK: Item Selection
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        guard let hero = list?[indexPath.row] else { return }
        
        let heroViewController = HeroDetailViewController(with: hero)
        
        navigationController?.pushViewController(heroViewController, animated: true)
    }
}
