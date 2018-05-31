//
//  CitySearchAlternativesRouter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit.UIViewController

protocol CitySearchAlternativesRouter {
    
    func routeOnSelectedCurrentLocation()
    func routeToCitySelectionOnMap()
}

struct CitySearchAlternativesRouterImp : CitySearchAlternativesRouter {
    
    unowned let viewController: UIViewController
    
    let coordinateSelectionHandler: (CityCoordinate) -> Void
    let currentLocationSelectionHandler: () -> Void

    // MARK: - <CitySearchAlternativesRouter>
    
    func routeOnSelectedCurrentLocation() {
        currentLocationSelectionHandler()
    }

    func routeToCitySelectionOnMap() {
        
        let citySelectionOnMapViewController = newCitySelectionOnMapViewController(selectionHandler: coordinateSelectionHandler)
        let navigationController = viewController.navigationController!
        let childNavigationController = UINavigationController(rootViewController: citySelectionOnMapViewController)
        navigationController.showDetailViewController(childNavigationController, sender: self)
    }
}

extension CitySearchAlternativesViewController /* Routing via Unwind Segues */ {
    
    @IBAction func unwindOnCancelCitySelectionOnMap(_ segue: UIStoryboardSegue) {
    }
}
