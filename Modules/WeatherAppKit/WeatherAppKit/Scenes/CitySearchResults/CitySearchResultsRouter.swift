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
    func routeToList(_: [CityInfo], selectionHandler: @escaping (CityInfo) -> Void)
}

class CitySearchResultsRouterImp : CitySearchResultsRouter {
    
    weak var viewController: UIViewController?
    let searchResultsSuperview: UIStackView
    
    init(viewController: UIViewController, searchResultsSuperview: UIStackView) {
        self.viewController = viewController
        self.searchResultsSuperview = searchResultsSuperview
    }
    
    var searchResultsViewController: UIViewController? {
        willSet {
            if let searchResultsViewController = searchResultsViewController {
                viewController?.removeChildViewController(searchResultsViewController, from: searchResultsSuperview)
            }
        }
        didSet {
            if let searchResultsViewController = searchResultsViewController {
                viewController?.addChildViewController(searchResultsViewController, to: searchResultsSuperview)
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
    
    func routeToList(_ searchResults: [CityInfo], selectionHandler: @escaping (CityInfo) -> Void) {
        self.searchResultsViewController = newCitySearchResultsListViewController(searchResults, selectionHandler: selectionHandler)
    }
}
