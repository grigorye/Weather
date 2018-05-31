//
//  UserCitiesRouter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject
import UIKit

protocol UserCitiesActionsRouter {
    
    func routeToAddCity()
}

struct UserCitiesActionsRouterImp : UserCitiesActionsRouter {
    
    unowned let viewController: UIViewController
    let container: Container
    
    // MARK: - <UserCitiesActionsRouter>
    
    func routeToAddCity() {
        let addCityViewController = newAddCityViewController(parentContainer: container)
        viewController.present(addCityViewController, animated: true)
    }
}
