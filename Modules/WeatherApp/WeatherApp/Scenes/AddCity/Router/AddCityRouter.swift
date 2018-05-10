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
    let searchContainerView: UIStackView
    
    init(viewController: UIViewController, searchContainerView: UIStackView) {
        self.viewController = viewController
        self.searchContainerView = searchContainerView
    }
    
    var searchViewController: UIViewController? {
        willSet {
            if let searchViewController = searchViewController {
                viewController.removeChildViewController(searchViewController, from: searchContainerView)
            }
        }
        didSet {
            if let searchViewController = searchViewController {
                viewController.addChildViewController(searchViewController, to: searchContainerView)
            }
        }
    }
    
    func routeToNoSearch() {
        self.searchViewController = newCityNoSearchViewController()
    }
    
    func routeToSearch(for text: String) {
        self.searchViewController = newCitySearchViewController(for: text)
    }
}
