//
//  UserCitiesRouter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol UserCitiesRouter {
    
    func routeToAddCity()
}

struct UserCitiesRouterImp : UserCitiesRouter {
    
    let viewController: UIViewController
    
    // MARK: - <UserCitiesRouter>
    
    func routeToAddCity() {
        let addCityViewController = newAddCityViewController()
        viewController.present(addCityViewController, animated: true)
    }
}
