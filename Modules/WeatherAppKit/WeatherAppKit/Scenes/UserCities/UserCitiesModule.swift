//
//  UserCitiesModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

func newUserCitiesViewController() -> UIViewController {
    
    return UserCitiesModule.newViewController()
}

enum UserCitiesModule : ContainerViewModule {
    
    static func newViewController() -> UIViewController {
        
        let viewController = instantiateViewController()
        
        let containerView = viewController as! ContainerView

        let router: Router = UserCitiesRouterImp(viewController: viewController)
        let presenter: Presenter = UserCitiesPresenterImp(router: router)
        
        UserCityListModule.prepare(containerView.listViewController)
        
        let actionsViewController = containerView.actionsViewController
        let actionsView = actionsViewController as! UserCitiesActionsView
        
        actionsView.delegate = presenter
        actionsViewController.retainObject(presenter)

        return viewController
    }
    
    // MARK: -
    
    typealias ContainerView = UserCitiesContainerView
    typealias Interactor = ()
    typealias Presenter = UserCitiesPresenter
    typealias Router = UserCitiesRouter
    typealias ViewController = UserCitiesViewController
    
    static let storyboardName = "UserCities"
}
