//
//  AddCityModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 09/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

func newAddCityViewController() -> UIViewController {
    
    let storyboard = UIStoryboard(name: "AddCity", bundle: .current)
    let viewController = storyboard.instantiateInitialViewController()!
    let view = viewController as! AddCityView
    
    let searchContainerView = (viewController as! AddCityViewController).searchContainerView
    
    let router: AddCityRouter = AddCityRouterImp(viewController: viewController, searchContainerView: searchContainerView)

    let interactor = AddCityInteractorImp()
    let presenter: AddCityPresenter = AddCityPresenterImp(interactor: interactor, router: router)
    view.delegate = presenter
    viewController.retainObject(presenter)
    
    router.routeToNoSearch()

    return viewController
}
