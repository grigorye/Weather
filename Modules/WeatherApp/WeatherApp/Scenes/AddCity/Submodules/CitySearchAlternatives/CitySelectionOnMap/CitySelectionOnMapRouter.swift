//
//  CitySelectionOnMapRouter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol CitySelectionOnMapRouter {
    
    func routeOnSelect()
    func routeOnCancel()
}

class CitySelectionOnMapRouterImp : CitySelectionOnMapRouter {
    
    let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    // MARK: - <CitySelectionOnMapRouter>
    
    func routeOnSelect() {
        viewController.performSegue(withIdentifier: "unwindFromAddCity", sender: self) // !!!
    }
    
    func routeOnCancel() {
        viewController.performSegue(withIdentifier: "unwindOnCancelCitySelectionOnMap", sender: self) // !!!
    }
}
