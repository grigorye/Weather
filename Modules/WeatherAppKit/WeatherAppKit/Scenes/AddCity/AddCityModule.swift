//
//  AddCityModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 09/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import SwinjectStoryboard
import Swinject
import UIKit

extension AddCityViewController : AddCityContainerView {}

protocol AddCityModule : class {
    
    func newViewController() -> UIViewController
}

class AddCityModuleImp : AddCityModule, ContainerViewModule_V2 {
    
    init(parentContainer: Container) {
        
        let container = Container(parent: parentContainer, defaultObjectScope: .container)
        self.container = container
        
        container.register(Interactor.self) { r in
            InteractorImp(
                userCitiesProvider: r.resolve(UserCitiesProvider.self)!
            )
        }
        
        weak var presenter: Presenter!
        container.register(Presenter.self, factory: { r in
            PresenterImp(
                router: r.resolve(Router.self)!,
                interactor: r.resolve(Interactor.self)!
            )
        }).initCompleted { (r, p) in
            presenter = p
        }
        
        container.register(Router.self) { r in
            return AddCityRouterImp(
                viewController: r.resolve((UIViewController & ContainerView).self)!,
                containerView: r.resolve(ContainerView.self)!.searchContainerView,
                cityInfoSelectionHandler: { presenter.cityInfoSelectionHandler($0) },
                coordinateSelectionHandler: { presenter.coordinateSelectionHandler($0) },
                currentLocationSelectionHandler: { presenter.currentLocationSelectionHandler() }
            )
        }
        let storyboardContainer = parentContainer.resolve(StoryboardContainerProvider.self)!.container
        storyboardContainer.storyboardInitCompleted(ViewController.self) { [unowned self] (r, c) in
            self.storyboardInitCompleted(viewController: c)
        }
        parentContainer.register(CitySearchInputDelegate.self, factory: { [unowned container] r in
            return container.resolve(Presenter.self)!
        })
    }
    
    func storyboardInitCompleted(viewController: UIViewController & ContainerView) {
        
        container.register((UIViewController & ContainerView).self, factory: { [weak viewController] _ in
            viewController!
        })
        container.register((ContainerView).self, factory: { [weak viewController] _ in
            viewController!
        })
        
        let presenter = container.resolve(Presenter.self)!
        
        let router = container.resolve(Router.self)!
        
        viewController.retainObject(presenter)
        
        router.routeToNoSearch()
    }
    
    deinit {()}
    
    // MARK: -
    
    typealias ContainerView = AddCityContainerView
    typealias Interactor = AddCityInteractor
    typealias Presenter = AddCityPresenter
    typealias Router = AddCityRouter
    typealias ViewController = AddCityViewController
    
    typealias InteractorImp = AddCityInteractorImp
    typealias PresenterImp = AddCityPresenterImp
    typealias RouterImp = AddCityRouterImp
    
    let storyboardName = "AddCity"
    let container: Container
}
