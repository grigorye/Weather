//
//  AddCityRouter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol AddCityRouter {
    
    func routeToNoSearch()
    func routeToSearch(for text: String, type: CitySearchInputType)
    func routeToCancelSearch()
    func routeToAddedCity()
}

class AddCityRouterImp : AddCityRouter {
    
    unowned let viewController: UIViewController
    let containerView: UIStackView
    let cityInfoSelectionHandler: (CityInfo) -> Void
    let coordinateSelectionHandler: (CityCoordinate) -> Void
    let currentLocationSelectionHandler: () -> Void

    init(viewController: UIViewController, containerView: UIStackView, cityInfoSelectionHandler: @escaping (CityInfo) -> Void, coordinateSelectionHandler: @escaping (CityCoordinate) -> Void, currentLocationSelectionHandler: @escaping () -> Void) {
        
        self.viewController = viewController
        self.containerView = containerView
        self.cityInfoSelectionHandler = cityInfoSelectionHandler
        self.coordinateSelectionHandler = coordinateSelectionHandler
        self.currentLocationSelectionHandler = currentLocationSelectionHandler
    }
    
    var searchViewController: UIViewController? {
        willSet {
            if let searchViewController = searchViewController {
                viewController.removeChildViewController(searchViewController, from: containerView)
            }
        }
        didSet {
            if let searchViewController = searchViewController {
                viewController.addChildViewController(searchViewController, to: containerView)
            }
        }
    }
    
    // MARK: - <AddCityRouter>
    
    func routeToNoSearch() {
        self.searchViewController = newCitySearchAlternativesViewController(
            coordinateSelectionHandler: coordinateSelectionHandler,
            currentLocationSelectionHandler: currentLocationSelectionHandler
        )
    }
    
    func routeToSearch(for text: String, type: CitySearchInputType) {
        let searchViewController: UIViewController = {
            switch type {
            case .cityName:
                return newCitySearchResultsViewController(
                    for: text,
                    selectionHandler: cityInfoSelectionHandler
                )
            case .zipCode:
                return newCityZipSearchResultsViewController(
                    for: text,
                    selectionHandler: cityInfoSelectionHandler
                )
            }
        }()
        self.searchViewController = searchViewController
    }
    
    func routeToCancelSearch() {
        viewController.performSegue(withIdentifier: "unwindFromAddCity", sender: self)
    }
    
    func routeToAddedCity() {
        viewController.performSegue(withIdentifier: "unwindFromAddCity", sender: self)
    }
}
