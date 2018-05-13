//
//  CitySearchAlternativesRouter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit.UIViewController

protocol CitySearchAlternativesRouter {
    
    func routeOnAddedCurrentLocation()
    func routeToCitySelectionOnMap()
}

struct CitySearchAlternativesRouterImp : CitySearchAlternativesRouter {
    
    let viewController: UIViewController

    // MARK: - <CitySearchAlternativesRouter>
    
    func routeOnAddedCurrentLocation() {
        
        viewController.performSegue(withIdentifier: "unwindFromAddCity", sender: self)
    }

    func routeToCitySelectionOnMap() {
        
        let citySelectionOnMapViewController = newCitySelectionOnMapViewController()
        let navigationController = viewController.navigationController!
        let childNavigationController = UINavigationController(rootViewController: citySelectionOnMapViewController)
        navigationController.showDetailViewController(childNavigationController, sender: self)
    }
}

extension CitySearchAlternativesViewController /* Routing via Unwind Segues */ {
    
    @IBAction func unwindOnCancelCitySelectionOnMap(_ segue: UIStoryboardSegue) {
    }
}
