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
    
    let collectionViewController: HeroCollectionViewController
    
    fileprivate var searchController: SearchController?
    
    init(with child: HeroCollectionViewController = HeroCollectionViewController()) {
        
        collectionViewController = child
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "MARVEL"
        
        addSubviews()
        configureEdges()
        layout()
        configureTouches()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    private func addSubviews() {
        
        addChildViewController(collectionViewController)
        view.addSubview(collectionViewController.view)
    }
    
    private func configureEdges() {
        
        constrain(view, collectionViewController.view) { container, collection in
            
            collection.edges == container.edges
        }
    }
    
    private func layout() {
        
        view.backgroundColor = UIColor.darkGray
    }
    
    fileprivate func configureNavigationBar() {
        
        if let bar = navigationController?.navigationBar as? NavigationBar {
            
            bar.isTranslucent = false
        }
        
        navigationItem.titleView = nil

        // Adds the SearchButton to the Controllers NavigationItem
        let searchButton = UIBarButtonItem(
            barButtonSystemItem: .search, target: self, action: #selector(activateSearch)
        )
        
        navigationItem.rightBarButtonItem = searchButton
    }
    
    private func configureTouches() {
        
        if(traitCollection.forceTouchCapability == .available) {
        
            registerForPreviewing(with: self, sourceView: view)
        }
    }
}

// MARK: - Search Controller
extension MainViewController {
    
    func activateSearch() {
        
        searchController = SearchController(cancelAction: deactivateSearch,
                                            submitAction: search(_:))
        
        guard let searchController = searchController else { return }
        
        let items: [UIBarButtonItem] = (navigationItem.leftBarButtonItems ?? [])
            + (navigationItem.rightBarButtonItems ?? [])
        
        _ = items.flatMap { item in
            UIView.animate(withDuration: 0.3, animations: {
                item.tintColor = Colors.clear
                item.customView?.alpha = 0
            })
        }
        
        let searchBarFrame = searchController.searchBar.frame
        
        navigationItem.rightBarButtonItem = nil
        searchController.searchBar.alpha = 0
        
        searchController.searchBar.frame = CGRect(
            x: searchBarFrame.origin.x,
            y: searchBarFrame.size.height,
            width: searchBarFrame.size.width,
            height: searchBarFrame.size.height
        )
        
        navigationItem.titleView = searchController.searchBar
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.searchController?.searchBar.alpha = 1
        },
        completion: { [weak self] _ in
            self?.searchController?.searchBar.setShowsCancelButton(true, animated: true)
            self?.searchController?.searchBar.becomeFirstResponder()
        })
    }
    
    func deactivateSearch() {

        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.searchController?.searchBar.alpha = 0
        },
       completion: { [weak self] _ in
            self?.configureNavigationBar()
        })
    }
    
    func search(_ text: String?) {
        collectionViewController.filter = text
    }
}

// MARK: - Previewing Delegate
extension MainViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                           viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let heroPreviewVC = collectionViewController.previewingViewController(at: location)
        
        heroPreviewVC?.preferredContentSize = CGSize(width: 0.0, height: 300)
        
        previewingContext.sourceRect = collectionViewController.cellRect(at: location)
        
        return heroPreviewVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        
        guard let heroViewController = viewControllerToCommit as? HeroDetailViewController else { return }
        
        navigationController?.pushViewController(heroViewController, animated: true)
    }
}
