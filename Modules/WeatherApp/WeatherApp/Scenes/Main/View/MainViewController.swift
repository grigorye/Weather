//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

class MainViewController : UISplitViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        masterNavigationController = forceCasted(viewControllers[0])
        detailNavigationController = forceCasted(viewControllers[1])
        
        let userCityListViewController = newUserCityListViewController()
        masterNavigationController.viewControllers = [userCityListViewController]
    }
    
    private var masterNavigationController: UINavigationController!
    private var detailNavigationController: UINavigationController!
}
