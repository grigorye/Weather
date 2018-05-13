//
//  AddCityModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 09/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

func newAddCityViewController() -> UIViewController {
    return AddCityModule.newModuleViewController()
}

extension AddCityViewController : AddCityContainerView {}

enum AddCityModule : ContainerViewModule {
    
    typealias ContainerView = AddCityContainerView
    typealias Interactor = AddCityInteractor
    typealias Presenter = AddCityPresenter
    typealias Router = AddCityRouter
    typealias ViewController = AddCityViewController
    
    static let storyboardName = "AddCity"
    
    static func newModuleViewController() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "AddCity", bundle: .current)
        
        let navigationController = storyboard.instantiateInitialViewController()! as! UINavigationController
        
        let viewController = navigationController.viewControllers.first!
        let containerView = viewController as! ContainerView
        
        let searchContainerView = containerView.searchContainerView
        
        let searchInputViewController = containerView.searchInputViewController
        
        let userCitiesProvider = defaultUserCitiesProvider()
        
        let interactor: Interactor = AddCityInteractorImp(userCitiesProvider: userCitiesProvider)
        var presenter: Presenter!
        let router: Router = AddCityRouterImp(
            viewController: viewController,
            containerView: searchContainerView,
            cityInfoSelectionHandler: { presenter.cityInfoSelectionHandler($0) },
            coordinateSelectionHandler: { presenter.coordinateSelectionHandler($0) },
            currentLocationSelectionHandler: { presenter.currentLocationSelectionHandler() }
        )
        
        presenter = AddCityPresenterImp(router: router, interactor: interactor)
        
        viewController.retainObject(presenter)

        router.routeToNoSearch()
        
        CitySearchInputModule.bind(searchInputViewController, viewDelegate: presenter)
        
        return navigationController
    }
}
