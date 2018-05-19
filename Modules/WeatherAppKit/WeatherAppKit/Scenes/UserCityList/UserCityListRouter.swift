//
//  UserCityRouter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol UserCityListRouter {
    
    func routeToUserCityWithLastWeather(_: UserCityInfoAndLastWeather)
}

struct UserCityListRouterImp : UserCityListRouter {
    
    let viewController: UIViewController
    
    // MARK: - <UserCityListRouter>
    
    func routeToUserCityWithLastWeather(_ userCityInfoAndLastWeather: UserCityInfoAndLastWeather) {

        let weatherDetailViewController = newWeatherDetailViewController(for: userCityInfoAndLastWeather)
        
        let navigationController = viewController.navigationController!
        navigationController.pushViewController(weatherDetailViewController, animated: true)
    }
}
