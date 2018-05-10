//
//  CityListModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

func newUserCityListViewController() -> UIViewController {
    
    let storyboard = UIStoryboard(name: "UserCityList", bundle: .current)
    
    let viewController = storyboard.instantiateInitialViewController()!
    let view = viewController as! UserCityListView

    let router: UserCityListRouter = UserCityListRouterImp(viewController: viewController)

    let userCitiesProvider: UserCitiesProvider = defaultUserCitiesProvider()
    let weatherProvider: WeatherProvider = defaultWeatherProvider()
    let interactor: UserCityListInteractor = UserCityListInteractorImp(userCitiesProvider: userCitiesProvider, weatherProvider: weatherProvider)
    
    let presenter: UserCityListPresenter = UserCityListPresenterImp(view: view, interactor: interactor, router: router)
    
    view.delegate = presenter
    viewController.retainObject(presenter)

    presenter.loadContent()
    
    return viewController
}
