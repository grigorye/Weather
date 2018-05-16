//
//  UserCityRouter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol UserCityListRouter {
    
    func routeToUserCityWithLastWeather(_: UserCityWithLastWeather)
}

struct UserCityListRouterImp : UserCityListRouter {
    
    let viewController: UIViewController
    
    // MARK: - <UserCityListRouter>
    
    func routeToUserCityWithLastWeather(_ userCityWithLastWeather: UserCityWithLastWeather) {

        let weatherDetailViewController = newWeatherDetailViewController(for: userCityWithLastWeather)
        
        let navigationController = viewController.navigationController!
        navigationController.pushViewController(weatherDetailViewController, animated: true)
    }
}
