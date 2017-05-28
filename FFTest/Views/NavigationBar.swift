//
//  NavigationBar.swift
//  FFTest
//
//  Created by Francisco Amado on 28/05/2017.
//  Copyright © 2017 franciscoamado. All rights reserved.
//

import UIKit

class NavigationBar: UINavigationBar {
    
    internal var statusBarHeight: CGFloat {
        
        return UIApplication.shared.statusBarFrame.height
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setup() {
        // Set Navigation Bar to opaque
        setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        shadowImage = UIImage()
        isTranslucent = false
        
        // Set Navigation Bar style
        barTintColor = Colors.brightGray
        barStyle = .black
        
        titleTextAttributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 20),
            NSForegroundColorAttributeName: Colors.white]
        tintColor = Colors.white
        
        self.topItem?.title = "MARVEL"
    }
}
