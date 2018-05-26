//
//  UserCitiesModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject
import UIKit

protocol UserCitiesModule : class {
    
    func newViewController(parentContainer: Container?) -> UIViewController
}

class UserCitiesModuleImp : UserCitiesModule, ContainerViewModule_V2 {
    
    init(parentContainer: Container) {
        
        let container = Container(parent: parentContainer)
        self.container = container
        
        parentContainer.storyboardInitCompleted(ViewController.self) { r, c in
            
            container.register((UIViewController & ContainerView).self) { _ in c }
            container.register((ContainerView).self) { _ in c }
        }
    }

    // MARK: -
    
    typealias ContainerView = UserCitiesContainerView
    typealias Interactor = ()
    typealias Presenter = ()
    typealias Router = ()
    typealias ViewController = UserCitiesViewController
    
    let storyboardName = "UserCities"
    let container: Container
}
