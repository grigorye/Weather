//
//  WeatherDetailModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

func newWeatherDetailViewController(for userCityWithWeather: UserCityWithWeather) -> UIViewController {
    
    let storyboard = UIStoryboard(name: "WeatherDetail", bundle: .current)
    
    let viewController = storyboard.instantiateInitialViewController()!
    let view = viewController as! WeatherDetailView

    let presenter: WeatherDetailPresenter = WeatherDetailPresenterImp(view: view, userCityWithWeather: userCityWithWeather)
    
    viewController.retainObject(presenter)
    
    presenter.loadContent()
    
    return viewController
}
