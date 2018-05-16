//
//  CitySearchAlternativesModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

func newCitySearchAlternativesViewController(coordinateSelectionHandler: @escaping (CityCoordinate) -> Void, currentLocationSelectionHandler: @escaping () -> Void) -> UIViewController {
    
    return CitySearchAlternativesModule.newModuleViewController(
        coordinateSelectionHandler: coordinateSelectionHandler,
        currentLocationSelectionHandler: currentLocationSelectionHandler
    )
}

enum CitySearchAlternativesModule : ViewModule {
    
    static func newModuleViewController(coordinateSelectionHandler: @escaping (CityCoordinate) -> Void, currentLocationSelectionHandler: @escaping () -> Void) -> UIViewController {
        
        let viewController = instantiateViewController()
        
        let view = viewController as! View
        
        let router: Router = CitySearchAlternativesRouterImp(
            viewController: viewController,
            coordinateSelectionHandler: coordinateSelectionHandler,
            currentLocationSelectionHandler: currentLocationSelectionHandler
        )
        
        let presenter: Presenter = CitySearchAlternativesPresenterImp(
            router: router
        )
        
        view.delegate = presenter
        viewController.retainObject(presenter)
        
        return viewController
    }
    
    // MARK: - <ViewModule>
    
    typealias View = CitySearchAlternativesView
    typealias Interactor = ()
    typealias Presenter = CitySearchAlternativesPresenter
    typealias Router = CitySearchAlternativesRouter
    typealias ViewController = CitySearchAlternativesViewController
    
    static let storyboardName = "CitySearchAlternatives"
}
