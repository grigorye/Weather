//
//  UserCitiesActionsModule.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 26/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject

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
                container: container
            )
        }
        
        parentContainer.storyboardInitCompleted(ViewController.self) { r, c in
            
            self.storyboardInitCompleted(viewController: c)
        }
    }

    func storyboardInitCompleted(viewController: UIViewController & View) {
        
        container.register((UIViewController & View).self) { _ in viewController }
        container.register((View).self) { _ in viewController }

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
