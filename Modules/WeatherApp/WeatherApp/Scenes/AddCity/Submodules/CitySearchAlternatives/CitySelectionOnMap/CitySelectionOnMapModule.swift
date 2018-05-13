//
//  CitySelectionOnMapModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

enum CitySelectionOnMapModule {
    
    typealias View = CitySelectionOnMapView
    typealias Interactor = CitySelectionOnMapInteractor
    typealias Presenter = CitySelectionOnMapPresenter
    typealias Router = CitySelectionOnMapRouter

    private static let storyboardName = "CitySelectionOnMap"

    static func newModuleViewController() -> UIViewController {
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: .current)
        let viewController = storyboard.instantiateInitialViewController()!
        let view = viewController as! View
        
        let router: Router = CitySelectionOnMapRouterImp(viewController: viewController)
        
        let userCitiesProvider = defaultUserCitiesProvider()
        let interactor: Interactor = CitySelectionOnMapInteractorImp(userCitiesProvider: userCitiesProvider)
        
        let presenter: Presenter = CitySelectionOnMapPresenterImp(interactor: interactor, router: router)
        
        view.delegate = presenter
        viewController.retainObject(presenter)
        
        return viewController
    }
}

func newCitySelectionOnMapViewController() -> UIViewController {
    
    return CitySelectionOnMapModule.newModuleViewController()
}
