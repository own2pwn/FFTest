//
//  MainViewController.swift
//  FFTest
//
//  Created by Francisco Amado on 27/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit
import Cartography

class MainViewController: UIViewController {
    
    fileprivate let provider: Provider
    fileprivate var list: [Hero]? {
        
        didSet { collectionView.reloadData() }
    }
    
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
        
        _ = provider.fetchList(startingAt: 0, size: 20)
            .then { list -> Void in
                
                self.list = list
            }
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
    
    fileprivate lazy var collectionView: UICollectionView = MainViewController.newCollectionView()
}

// MARK: - UI Extension
extension MainViewController {
    
    fileprivate final class func newCollectionView() -> UICollectionView {
        
        let layout = UICollectionViewFlowLayout().tap {
            
            $0.minimumInteritemSpacing = 0
            $0.minimumLineSpacing = 0
        }
        
        let top: CGFloat = 0
        
        return UICollectionView(frame: CGRect.zero, collectionViewLayout: layout).tap {
            
            $0.backgroundColor = Colors.charcoalGrey
            $0.contentInset.top = top
            $0.contentInset.bottom = 0
            $0.scrollIndicatorInsets.top = top
            
            $0.register(class: HeroCell.self)
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    
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
//                                        $0.layer.shouldRasterize = true
//                                        $0.layer.rasterizationScale = UIScreen.main.scale
                                        
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width / 2,
                      height: HeroCell.preferredHeight)
    }
}
