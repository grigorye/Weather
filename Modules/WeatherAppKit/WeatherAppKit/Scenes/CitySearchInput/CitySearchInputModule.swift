//
//  CitySearchInputModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

enum CitySearchInputModule : ViewModule {
    
    static func bind(_ viewController: UIViewController, delegate: CitySearchInputDelegate) {
        
        let view = viewController as! View
        
        let interactor: Interactor = CitySearchInputInteractorImp()
        let presenter: Presenter = CitySearchInputPresenterImp(view: view, interactor: interactor, delegate: delegate)
        
        viewController.retainObject(presenter)
        view.delegate = presenter
        
        presenter.loadContent()
    }
    
    // MARK: -
    
    typealias View = CitySearchInputView
    typealias Interactor = CitySearchInputInteractor
    typealias Presenter = CitySearchInputPresenter
    typealias Router = ()
    typealias ViewController = CitySearchInputViewController

    static let storyboardName = "CitySearchInput"
}
