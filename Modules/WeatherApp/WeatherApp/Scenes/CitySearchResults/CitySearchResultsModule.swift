//
//  CitySearchResultsModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 09/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

func newCitySearchResultsViewController(for text: String, selectionHandler: @escaping (CityInfo) -> Void) -> UIViewController {
    
    return CitySearchResultsModule.newViewController(for: text, selectionHandler: selectionHandler)
}

enum CitySearchResultsModule : ContainerViewModule {
    
    static func newViewController(for text: String, selectionHandler: @escaping (CityInfo) -> Void) -> UIViewController {
        
        let viewController = instantiateViewController()
        
        let containerView = viewController as! ContainerView
        
        let searchResultsSuperview = containerView.searchResultsSuperview
        
        let interactor: Interactor = CitySearchResultsInteractorImp(
            weatherProvider: defaultWeatherProvider(),
            cityProvider: defaultCityProvider()
        )
        
        let router: Router = CitySearchResultsRouterImp(
            viewController: viewController,
            searchResultsSuperview: searchResultsSuperview
        )
        
        let presenter: Presenter = CitySearchResultsPresenterImp(
            interactor: interactor,
            router: router,
            selectionHandler: selectionHandler
        )
        
        viewController.retainObject(presenter)
        
        presenter.loadContent(forSearchMatch: text)
        
        return viewController
    }
    
    // MARK: -
    
    typealias ContainerView = CitySearchResultsContainerView
    typealias Interactor = CitySearchResultsInteractor
    typealias Presenter = CitySearchResultsPresenter
    typealias Router = CitySearchResultsRouter
    typealias ViewController = CitySearchResultsViewController
    
    static let storyboardName = "CitySearchResults"
}
