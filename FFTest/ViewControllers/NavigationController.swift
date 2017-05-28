//
//  NavigationController.swift
//  FFTest
//
//  Created by Francisco Amado on 28/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    init(rootViewController: UIViewController, navigationBarClass: AnyClass? = NavigationBar.self) {
        
        super.init(navigationBarClass: navigationBarClass, toolbarClass: nil)
        
        viewControllers = [rootViewController]
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
