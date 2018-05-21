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
        
        present(weatherDetailViewController, for: userCityInfoAndLastWeather)
    }
    
    // MARK: -
    
    func present(_ detailViewController: UIViewController, for userCityInfoAndLastWeather: UserCityInfoAndLastWeather) {
        
        let navigationController = viewController.navigationController!
        
        prepareCustomTransitioning(via: navigationController, for: userCityInfoAndLastWeather)

        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func prepareCustomTransitioning(via navigationController: UINavigationController, for userCityInfoAndLastWeather: UserCityInfoAndLastWeather) {
        
        let location = userCityInfoAndLastWeather.userCityInfo.location
        let cellFrame = (viewController as! UserCityCellTransitioningSource).cellFrame(for: location)
        
        let savedNavigationControllerDelegate = navigationController.delegate
        var transitioningDelegate: UINavigationControllerDelegate?
        transitioningDelegate = CellTransitioningNavigationControllerDelegate(cellFrame: cellFrame, popCompletionHandler: {
            navigationController.delegate = savedNavigationControllerDelegate
            transitioningDelegate = nil
        })
        
        navigationController.delegate = transitioningDelegate
    }
}
