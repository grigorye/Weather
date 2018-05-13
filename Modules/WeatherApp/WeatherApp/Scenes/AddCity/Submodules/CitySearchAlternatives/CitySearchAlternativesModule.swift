//
//  CitySearchAlternativesModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

func newCitySearchAlternativesViewController() -> UIViewController {
    
    return CitySearchAlternativesModule.newModuleViewController()
}

enum CitySearchAlternativesModule : Module {
    
    typealias View = CitySearchAlternativesView
    typealias Interactor = CitySearchAlternativesInteractor
    typealias Presenter = CitySearchAlternativesPresenter
    typealias Router = CitySearchAlternativesRouter
    typealias ViewController = CitySearchAlternativesViewController
    
    private static let storyboardName = "CitySearchAlternatives"
    
    static func newModuleViewController() -> UIViewController {
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: .current)
        let viewController = storyboard.instantiateInitialViewController()!
        let view = viewController as! View
        
        let router: Router = CitySearchAlternativesRouterImp(viewController: viewController)
        
        let userCitiesProvider = defaultUserCitiesProvider()
        let interactor: Interactor = CitySearchAlternativesInteractorImp(userCitiesProvider: userCitiesProvider)
        
        let presenter: Presenter = CitySearchAlternativesPresenterImp(interactor: interactor, router: router)
        
        view.delegate = presenter
        viewController.retainObject(presenter)
        
        return viewController
    }
}
