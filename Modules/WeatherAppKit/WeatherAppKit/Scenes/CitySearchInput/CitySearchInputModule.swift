//
//  CitySearchInputModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import SwinjectStoryboard
import Swinject
import UIKit

protocol CitySearchInputModule : class {}

class CitySearchInputModuleImp : CitySearchInputModule, ViewModule_V2 {
    
    init(parentContainer: Container) {
        
        let container = Container(parent: parentContainer)
        self.container = container
        
        container.do {
            $0.register(Interactor.self) { _ in
                InteractorImp()
            }
            $0.register(Presenter.self, factory: { r in
                PresenterImp(
                    view: r.resolve(View.self)!,
                    interactor: r.resolve(Interactor.self)!
                )
            }).initCompleted { (r, presenter) in
                DispatchQueue.main.async {
                    presenter.delegate = r.resolve(CitySearchInputDelegate.self)!
                }
            }
        }
        
        parentContainer.storyboardInitCompleted(ViewController.self) { (r, c) in
            self.storyboardInitCompleted(viewController: c)
        }
    }
    
    func storyboardInitCompleted(viewController: (ViewController & View)) {
        
        let view = viewController as View

        container.register((UIViewController & View).self) { _ in viewController }
        container.register((View).self) { _ in view }

        let presenter = container.resolve(Presenter.self)!
        
        view.delegate = presenter
        viewController.retainObject(presenter)
        
        presenter.loadContent()
    }
    
    // MARK: -
    
    typealias View = CitySearchInputView
    typealias Interactor = CitySearchInputInteractor
    typealias Presenter = CitySearchInputPresenter
    typealias Router = ()
    typealias ViewController = CitySearchInputViewController

    typealias InteractorImp = CitySearchInputInteractorImp
    typealias PresenterImp = CitySearchInputPresenterImp

    let storyboardName = "CitySearchInput"
    let container: Container
    
    // MARK: -
    
    deinit {()}
}
