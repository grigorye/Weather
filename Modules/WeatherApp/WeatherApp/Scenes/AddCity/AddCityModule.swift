//
//  AddCityModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 09/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

func newAddCityViewController() -> UIViewController {
    
    let storyboard = UIStoryboard(name: "AddCity", bundle: .current)
    
    let navigationController = storyboard.instantiateInitialViewController()! as! UINavigationController
    
    let viewControllerObject = navigationController.viewControllers.first!
    let viewController = viewControllerObject as! AddCityViewController
    
    let searchContainerView = viewController.searchContainerView
    
    let searchInputViewController = viewController.childSearchInputViewController
    CitySearchInputModule.prepare(searchInputViewController, containerViewController: viewController, containerView: searchContainerView)

    return navigationController
}
