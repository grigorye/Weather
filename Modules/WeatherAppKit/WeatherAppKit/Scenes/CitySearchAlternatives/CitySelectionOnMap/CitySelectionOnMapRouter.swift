//
//  CitySelectionOnMapRouter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol CitySelectionOnMapRouter {
    
    func routeOnSelect(_: CityCoordinate)
    func routeOnCancel()
}

class CitySelectionOnMapRouterImp : CitySelectionOnMapRouter {
    
    unowned let viewController: UIViewController
    let selectionHandler: (CityCoordinate) -> Void
    
    init(viewController: UIViewController, selectionHandler: @escaping (CityCoordinate) -> Void) {
        self.viewController = viewController
        self.selectionHandler = selectionHandler
    }
    
    deinit {()}
    
    // MARK: - <CitySelectionOnMapRouter>
    
    func routeOnSelect(_ coordinate: CityCoordinate) {
        selectionHandler(coordinate)
    }
    
    func routeOnCancel() {
        viewController.performSegue(withIdentifier: "unwindOnCancelCitySelectionOnMap", sender: self) // !!!
    }
}
