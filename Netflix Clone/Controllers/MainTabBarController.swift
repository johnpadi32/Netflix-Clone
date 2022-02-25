//
//  MainTabBarController.swift
//  Netflix Clone
//
//  Created by John Padilla on 2/17/22.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController()
    }
    
    //MARK: - Helpers
    
    func navigationController() {
        
        let vc1 = templateNavigationController(Image: "house", title: "Home", rootViewController: HomeViewController())
        let vc2 = templateNavigationController(Image: "play.circle", title: "Coming Soon", rootViewController: UpcommingViewController())
        let vc3 = templateNavigationController(Image: "magnifyingglass", title: "Top Search", rootViewController: SearchController())
        let vc4 = templateNavigationController(Image: "arrow.down.to.line", title: "Downloads", rootViewController: DownloadViewController())
        
        viewControllers = [vc1, vc2, vc3, vc4]
        tabBar.tintColor = .label
    }
    
    func templateNavigationController(Image: String, title: String, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = UIImage(systemName: Image)
        nav.tabBarItem.title = title
        return nav
    }
}
