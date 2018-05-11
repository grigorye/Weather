//
//  UserCityRouter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol UserCityListRouter {
    
    func routeToUserCityWithWeather(_: UserCityWithWeather)
    func routeToAddCity()
}

struct UserCityListRouterImp : UserCityListRouter {
    
    var viewController: UIViewController
    
    // MARK: - <UserCityListRouter>
    
    func routeToUserCityWithWeather(_ userCityWithWeather: UserCityWithWeather) {

        let weatherDetailViewController = newWeatherDetailViewController(for: userCityWithWeather)
        
        let navigationController = viewController.navigationController!
        navigationController.pushViewController(weatherDetailViewController, animated: true)
    }
    
    func routeToAddCity() {
        let addCityViewController = newAddCityViewController()
        viewController.present(addCityViewController, animated: true)
    }
}