//
//  SearchBarViewController.swift
//  FFTest
//
//  Created by Francisco Amado on 30/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit

class SearchController: UISearchController {
    
    var cancelClicked: ((Void) -> Void)?
    var searchClicked: ((String?) -> Void)?
    
    convenience init(cancelAction: ((Void) -> Void)?, submitAction: ((String?) -> Void)?) {
        
        self.init(searchResultsController: nil)
        cancelClicked = cancelAction
        searchClicked = submitAction
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureSearchBar()
    }
    
    override init(searchResultsController: UIViewController?) {
        
        super.init(searchResultsController: searchResultsController)
        configureSearchBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    fileprivate func configureSearchBar() {
        
        hidesNavigationBarDuringPresentation = false
        
        searchBar.barStyle = .default
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = Colors.white
        searchBar.barTintColor = UIColor.black
        searchBar.isTranslucent = false
        searchBar.showsCancelButton = false
        
        searchBar.textField?.textColor = Colors.white
        searchBar.placeholderLabel?.textColor = Colors.white
        
        searchBar.delegate = self
    }
}

extension SearchController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text, searchText.isEmpty == false else {
            cancelClicked?()
            return
        }
        
        searchClicked?(searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text, searchText.isEmpty == false else {
            cancelClicked?()
            return
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelClicked?()
    }
}

// MARK: - UISearchBar Helpers
/// Private UISearchBar extension for providing handlers
/// for unaccessible properties
private extension UISearchBar {
    // Although accessed with KVC, we could also iterate
    // through the subviews and find the UITextField
    var textField: UITextField? {
        
        return value(forKey: "_searchField") as? UITextField
    }
    
    var placeholderLabel: UILabel? {
        
        return textField?.value(forKey: "_placeholderLabel") as? UILabel
    }
}
