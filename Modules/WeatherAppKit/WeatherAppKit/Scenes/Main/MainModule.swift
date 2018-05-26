//
//  MainModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject
import UIKit

extension MainViewController : MainContainerView, ContainerView_V2 {}

public func newMainViewController(parentContainer: Container? = sharedContainer) -> UIViewController {
    
    let container = Container(parent: parentContainer)
    
    let storyboard = UIStoryboard(name: "Main", bundle: .current)
    let viewController = storyboard.instantiateInitialViewController()!
    
    let containerView = viewController as! MainContainerView
    
    let userCitiesViewController = newUserCitiesViewController(parentContainer: container)

    let masterNavigationController = containerView.masterNavigationController
    masterNavigationController.viewControllers = [userCitiesViewController]

    return viewController
}

protocol MainModule {
    
    func newViewController(parentContainer: Container?) -> UIViewController
}

struct MainModuleImp : MainModule, ContainerViewModule_V2 {
    
    typealias ContainerView = View_V2
    
    typealias ViewController = MainViewController
    
    typealias Interactor = ()
    
    typealias Presenter = ()
    
    typealias Router = ()
    
    let storyboardName = "Main"
    
    let container: Container
}
