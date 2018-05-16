//
//  CitySelectionOnMapModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

func newCitySelectionOnMapViewController(selectionHandler: @escaping (CityCoordinate) -> Void) -> UIViewController {
    
    return CitySelectionOnMapModule.newModuleViewController(selectionHandler: selectionHandler)
}

extension CitySelectionOnMapViewController : CitySelectionOnMapView {}

enum CitySelectionOnMapModule : ModuleStoryboarding {
    
    typealias View = CitySelectionOnMapView
    typealias Presenter = CitySelectionOnMapPresenter
    typealias Router = CitySelectionOnMapRouter

    static let storyboardName = "CitySelectionOnMap"

    static func newModuleViewController(selectionHandler: @escaping (CityCoordinate) -> Void) -> UIViewController {
        
        let viewController = instantiateViewController()
        let view = viewController as! View
        
        let router: Router = CitySelectionOnMapRouterImp(viewController: viewController, selectionHandler: selectionHandler)
        
        let presenter: Presenter = CitySelectionOnMapPresenterImp(router: router)
        
        view.delegate = presenter
        viewController.retainObject(presenter)
        
        return viewController
    }
}
