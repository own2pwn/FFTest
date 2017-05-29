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
    
    init(with child: HeroCollectionViewController = HeroCollectionViewController()) {
        
        collectionViewController = child
        
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
}
