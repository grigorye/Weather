//
//  CitySearchInputModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

func newCitySearchInputViewController(containerViewController: UIViewController, containerView: UIStackView) -> UIViewController {
    
    return CitySearchInputModule.newModuleViewController(containerViewController: containerViewController, containerView: containerView)
}

class CitySearchInputInteractor {}

enum CitySearchInputModule : Module {
    
    typealias View = CitySearchInputView
    typealias Interactor = CitySearchInputInteractor
    typealias Presenter = CitySearchInputPresenter
    typealias Router = CitySearchInputRouter
    typealias ViewController = CitySearchInputViewController
    
    private static let storyboardName = "CitySearchInput"
    
    static func newModuleViewController(containerViewController: UIViewController, containerView: UIStackView) -> UIViewController {
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: .current)
        let viewController = storyboard.instantiateInitialViewController()!
        
        prepare(viewController, containerViewController: containerViewController, containerView: containerView)
        
        return viewController
    }
    
    static func prepare(_ viewController: UIViewController, containerViewController: UIViewController, containerView: UIStackView) {
        let view = viewController as! View
        
        let router: Router = CitySearchInputRouterImp(containerViewController: containerViewController, containerView: containerView)
        
        let presenter: Presenter = CitySearchInputPresenterImp(router: router)
        
        view.delegate = presenter
        viewController.retainObject(presenter)
        
        router.routeToNoSearch()
    }
}
