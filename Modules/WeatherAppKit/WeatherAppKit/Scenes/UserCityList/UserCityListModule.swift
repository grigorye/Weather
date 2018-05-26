//
//  CityListModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject
import UIKit

protocol UserCityListModule : class {
    
    func storyboardInitCompleted(viewController: UIViewController & UserCityListView)
}

class UserCityListModuleImp : UserCityListModule, ViewModule_V2, ModuleStoryboarding_V2 {
    
    init(parentContainer: Container) {
        
        let container = Container(parent: parentContainer)
        self.container = container
        
        container.register(Router.self) { r in
            return RouterImp(
                viewController: r.resolve((UIViewController & View).self)!
            )
        }
        container.register(Presenter.self) { r in
            return PresenterImp(
                view: r.resolve(View.self)!,
                interactor: r.resolve(Interactor.self)!,
                router: r.resolve(Router.self)!
            )
        }
        container.register(Interactor.self) { r in
            return InteractorImp(
                userCitiesProvider: r.resolve(UserCitiesProvider.self)!,
                weatherProvider: r.resolve(WeatherProvider.self)!,
                userCityRefresher: r.resolve(UserCityRefresher.self)!
            )
        }
        
        parentContainer.storyboardInitCompleted(ViewController.self) { (r, c) in
            
            self.storyboardInitCompleted(viewController: c)
        }
    }
    
    func storyboardInitCompleted(viewController: UIViewController & View) {
        
        container.register((UIViewController & View).self) { _ in viewController }
        container.register((View).self) { _ in viewController }

        let presenter = container.resolve(Presenter.self)!
        let view: View = viewController
        
        view.delegate = presenter
        viewController.retainObject(presenter)
        
        presenter.loadContent()
    }
    
    // MARK: -
    
    typealias View = UserCityListView
    typealias Interactor = UserCityListInteractor
    typealias Presenter = UserCityListPresenter
    typealias Router = UserCityListRouter
    typealias ViewController = UserCityListViewController
    
    typealias InteractorImp = UserCityListInteractorImp
    typealias PresenterImp = UserCityListPresenterImp
    typealias RouterImp = UserCityListRouterImp

    let storyboardName = "UserCityList"
    let container: Container
}

extension UserCityListViewController /* Routing via Unwind Segues */ {
    
    @IBAction func unwindFromAddCity(_ segue: UIStoryboardSegue) {
    }
}
