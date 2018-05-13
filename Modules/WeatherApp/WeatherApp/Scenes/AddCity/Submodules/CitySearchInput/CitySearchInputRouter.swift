//
//  CitySearchInputRouter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol CitySearchInputRouter {
    
    func routeToNoSearch()
    func routeToSearch(for text: String)
    func routeToCancelSearch()
}

class CitySearchInputRouterImp : CitySearchInputRouter {
    
    weak var containerViewController: UIViewController!
    let containerView: UIStackView
    
    init(containerViewController: UIViewController, containerView: UIStackView) {
        self.containerViewController = containerViewController
        self.containerView = containerView
    }
    
    var searchViewController: UIViewController? {
        willSet {
            if let searchViewController = searchViewController {
                containerViewController.removeChildViewController(searchViewController, from: containerView)
            }
        }
        didSet {
            if let searchViewController = searchViewController {
                containerViewController.addChildViewController(searchViewController, to: containerView)
            }
        }
    }
    
    func routeToNoSearch() {
        self.searchViewController = newCitySearchAlternativesViewController()
    }
    
    func routeToSearch(for text: String) {
        self.searchViewController = newCitySearchViewController(for: text)
    }
    
    func routeToCancelSearch() {
        self.containerViewController.performSegue(withIdentifier: "unwindFromAddCity", sender: self)
    }
}
