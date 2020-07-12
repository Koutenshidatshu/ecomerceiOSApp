//
//  TabBarViewController.swift
//  ecomerce-iOS
//
//  Created by Yonathan Wijaya on 12/07/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    lazy private var initialTabBar: HomeViewController = {
        
        let initialTabBar = HomeViewController()
        
        let title = "Home"
        let defaultImage = UIImage(named: "homeUnselected")!
        let selectedImage = UIImage(named: "homeSelected")!
        let tabBarItems = (title: title, image: defaultImage, selectedImage: selectedImage)
        let tabBarItem = UITabBarItem(title: tabBarItems.title, image: tabBarItems.image,
                                      selectedImage: tabBarItems.selectedImage)
        initialTabBar.tabBarItem = tabBarItem
        return initialTabBar
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewControllers = [initialTabBar]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
