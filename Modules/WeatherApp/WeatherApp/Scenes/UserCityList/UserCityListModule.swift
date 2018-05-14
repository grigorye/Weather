//
//  CityListModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

func newUserCityListViewController() -> UIViewController {
    
    return UserCityListModule.newViewController()
}

enum UserCityListModule : ViewModule {
    
    static func prepare(_ viewController: UIViewController) {
        
        let view = viewController as! UserCityListView
        
        let router: Router = UserCityListRouterImp(viewController: viewController)
        
        let userCitiesProvider: UserCitiesProvider = defaultUserCitiesProvider()
        let weatherProvider: WeatherProvider = defaultWeatherProvider()
        let locationService: LocationService = LocationServiceImp()
        
        let interactor: Interactor = UserCityListInteractorImp(userCitiesProvider: userCitiesProvider, weatherProvider: weatherProvider, locationService: locationService)
        
        let presenter: Presenter = UserCityListPresenterImp(view: view, interactor: interactor, router: router)
        
        view.delegate = presenter
        viewController.retainObject(presenter)
        
        presenter.loadContent()
    }
    
    static func newViewController() -> UIViewController {
        
        let viewController = instantiateViewController()
        
        prepare(viewController)
        
        return viewController
    }
    
    // MARK: -
    
    typealias View = UserCityListView
    typealias Interactor = UserCityListInteractor
    typealias Presenter = UserCityListPresenter
    typealias Router = UserCityListRouter
    typealias ViewController = UserCityListViewController
    
    static let storyboardName = "UserCityList"
}

extension UserCityListViewController /* Routing via Unwind Segues */ {
    
    @IBAction func unwindFromAddCity(_ segue: UIStoryboardSegue) {
    }
}
