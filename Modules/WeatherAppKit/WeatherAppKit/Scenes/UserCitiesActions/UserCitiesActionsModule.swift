//
//  UserCitiesActionsModule.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 26/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject
import UIKit

extension UserCitiesActionsViewController : UserCitiesActionsView {}

protocol UserCitiesActionsModule : class {}

class UserCitiesActionsModuleImp : ViewModule_V2, UserCitiesActionsModule {
    
    init(parentContainer: Container) {
        
        let container = Container(parent: parentContainer)
        self.container = container
        
        container.register(Presenter.self) { r in
            return PresenterImp(
                router: r.resolve(Router.self)!
            )
        }
        container.register(Router.self) { r in
            return RouterImp(
                viewController: r.resolve((UIViewController & View).self)!,
                container: parentContainer
            )
        }
        
        parentContainer.storyboardInitCompleted(ViewController.self) { [unowned container, unowned self] r, c in
            
            container.register((UIViewController & View).self) { [unowned c] _ in c }
            container.register((View).self) { [unowned c] _ in c }
            
            self.storyboardInitCompleted(viewController: c)
        }
    }

    func storyboardInitCompleted(viewController: UIViewController & View) {
        
        let presenter = container.resolve(Presenter.self)!
        let view = viewController as View
        
        view.delegate = presenter
        viewController.retainObject(presenter)
    }
    
    // MARK: -
    
    typealias View = UserCitiesActionsView
    
    typealias ViewController = UserCitiesActionsViewController
    
    typealias Interactor = ()
    
    typealias Presenter = UserCitiesActionsPresenter
    
    typealias Router = UserCitiesActionsRouter
    
    typealias PresenterImp = UserCitiesActionsPresenterImp
    
    typealias RouterImp = UserCitiesActionsRouterImp
    
    let storyboardName = "UserCitiesActions"
    
    let container: Container
}
