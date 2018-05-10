//
//  CitySearchResultsRouter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol CitySearchResultsRouter {
    
    func routeToError(_: Error)
    func routeToLoading()
    func routeToList(_: [CityInfo])
}

class CitySearchResultsRouterImp : CitySearchResultsRouter {
    
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
    
    // MARK: - <CitySearchResultsRouter>
    
    func routeToError(_ error: Error) {
        self.searchResultsViewController = newErrorStateViewController(error)
    }
    
    func routeToLoading() {
        self.searchResultsViewController = newLoadingStateViewController()
    }
    
    func routeToList(_ searchResults: [CityInfo]) {
        self.searchResultsViewController = newSearchResultsListViewController(searchResults)
    }
}
