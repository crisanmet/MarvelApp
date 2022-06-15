//
//  TabBarViewController.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 09/06/2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let characterVC = UINavigationController(rootViewController: CharacterViewController())
        let eventsVC = UINavigationController(rootViewController: EventsViewController())
        
        characterVC.tabBarItem.image = UIImage(systemName: "house")
        eventsVC.tabBarItem.image = UIImage(systemName: "play.circle")
        
        characterVC.title = "Characters"
        eventsVC.title = "Events"
        
        tabBar.tintColor = .label
        setViewControllers([characterVC, eventsVC], animated: true)
       
    }
    



}
