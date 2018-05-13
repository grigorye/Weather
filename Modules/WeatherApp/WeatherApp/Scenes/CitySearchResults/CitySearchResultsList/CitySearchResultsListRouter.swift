//
//  CitySearchResultsListRouter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 09/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol CitySearchResultsListRouter {
    
    func routeToSelectedCity(_ cityInfo: CityInfo)
}

class CitySearchResultsListRouterImp : CitySearchResultsListRouter {
    
    let viewController: UIViewController
    let selectionHandler: (CityInfo) -> Void
    
    init(viewController: UIViewController, selectionHandler: @escaping (CityInfo) -> Void) {
        
        self.viewController = viewController
        self.selectionHandler = selectionHandler
    }
    
    // MARK: - <CitySearchResultsListRouter>
    
    func routeToSelectedCity(_ cityInfo: CityInfo) {
        
        selectionHandler(cityInfo)
    }
}
