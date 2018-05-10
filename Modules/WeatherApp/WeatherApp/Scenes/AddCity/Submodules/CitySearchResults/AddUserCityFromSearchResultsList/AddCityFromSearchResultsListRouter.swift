//
//  AddCityFromSearchResultsListRouter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 09/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol AddCityFromSearchResultsListRouter {
    
    func routeToAddedCity()
}

class AddCityFromSearchResultsListRouterImp : AddCityFromSearchResultsListRouter {
    
    let viewController: UIViewController
    
    init(viewController: UIViewController) {
        
        self.viewController = viewController
    }
    
    // MARK: - <AddCityFromSearchResultsListRouter>
    
    func routeToAddedCity() {
        
        viewController.presentingViewController!.dismiss(animated: true)
    }
}
