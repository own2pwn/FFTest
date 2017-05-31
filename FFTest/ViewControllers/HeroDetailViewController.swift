//
//  HeroDetailViewController.swift
//  FFTest
//
//  Created by Francisco Amado on 29/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit
import PromiseKit
import Cartography

class HeroDetailViewController: UIViewController {
    
    let hero: Hero
    fileprivate var summaryViewController: SummaryCollectionViewController
    
    fileprivate lazy var header: HeroHeaderView = {
        
        let configuration = HeroHeaderViewConfiguration(
            title: self.hero.name,
            description: self.hero.description,
            image: self.hero.thumbnail?.asURL,
            backgroundImage: self.hero.thumbnail?.asURL
        )
        
        return HeroHeaderView(with: configuration)
    }()
    
    init(with hero: Hero) {
        
        self.hero = hero
        let summaries: [[Summary]?] = [hero.comics, hero.events, hero.stories, hero.series]
        let data: [SummarySection] = HeroDetailViewController.aggregated(list: summaries)
        self.summaryViewController = SummaryCollectionViewController(with: data)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = hero.strippedName
        
        addSubviews()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        configureNavigationBar()
    }
    
    private func addSubviews() {
        
        view.addSubview(header)
        addChildViewController(summaryViewController)
        view.addSubview(summaryViewController.view)
    }
    
    private func layout() {
        
        view.backgroundColor = UIColor.darkGray
        
        constrain(view, header, summaryViewController.view) { container, head, summary in
            
            head.top == container.top
            head.leading == container.leading
            head.trailing == container.trailing
            head.height == header.preferredHeight(for: view.bounds.width)
            
            summary.top == head.bottom
            summary.leading == container.leading
            summary.trailing == container.trailing
            summary.bottom == container.bottom
        }
    }
    
    private func configureNavigationBar() {
        
        guard let bar = navigationController?.navigationBar as? NavigationBar else {
            
            return
        }
        
        bar.isTranslucent = true
    }
    
    // MARK: - Previewing Actions
    override var previewActionItems: [UIPreviewActionItem] {
        
        let favouriteAction = UIPreviewAction(title: "Add to Favourites", style: .default) {
            (action, viewController) -> Void in
            
            // TODO: Add to Favorites section
        }
        
        return [favouriteAction]
    }
}

extension HeroDetailViewController {
    
    static func aggregated(list: [[Summary]?]) -> [SummarySection] {
        
        return list.flatMap(HeroDetailViewController.parsed)
    }
    
    static func parsed(summaryList: [Summary]?) -> SummarySection {
        
        let name: String? = summaryList?.first?.pluralClassName
        
        return  SummarySection(name: name, summaries: summaryList)
    }
}
