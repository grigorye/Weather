//
//  MainModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

extension MainViewController : MainContainerView {}

public func newMainViewController() -> UIViewController {
    
    let storyboard = UIStoryboard(name: "Main", bundle: .current)
    let viewController = storyboard.instantiateInitialViewController()!
    
    let containerView = viewController as! MainContainerView
    
    let userCitiesViewController = newUserCitiesViewController()
    
    let masterNavigationController = containerView.masterNavigationController
    masterNavigationController.viewControllers = [userCitiesViewController]

    return viewController
}
