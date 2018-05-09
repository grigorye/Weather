//
//  AddCityRouter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 09/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol AddCityRouter : class {

    func routeToNoSearch()
    func routeToSearch(for text: String)
}

class AddCityRouterImp : AddCityRouter {
    
    weak var viewController: UIViewController!
    let searchResultsContainerView: UIStackView
    
    init(viewController: UIViewController, searchResultsContainerView: UIStackView) {
        self.viewController = viewController
        self.searchResultsContainerView = searchResultsContainerView
    }
    
    var searchResultsViewController: UIViewController? {
        willSet {
            if let searchResultsViewController = searchResultsViewController {
                viewController.removeChildViewController(searchResultsViewController, from: searchResultsContainerView)
            }
        }
        didSet {
            if let searchResultsViewController = searchResultsViewController {
                viewController.addChildViewController(searchResultsViewController, to: searchResultsContainerView)
            }
        }
    }
    
    func routeToNoSearch() {
        self.searchResultsViewController = newCityNoSearchViewController()
    }
    
    func routeToSearch(for text: String) {
        self.searchResultsViewController = newCitySearchViewController(for: text)
    }
}
