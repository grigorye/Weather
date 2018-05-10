//
//  CitySearchResultsModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 09/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

func newCityNoSearchViewController() -> UIViewController {
    
    let storyboard = UIStoryboard(name: "CityNoSearch", bundle: .current)
    return storyboard.instantiateInitialViewController()!
}

func newCitySearchViewController(for text: String) -> UIViewController {
    
    let storyboard = UIStoryboard(name: "CitySearchResults", bundle: .current)
    let viewController = storyboard.instantiateInitialViewController()!

    let searchResultsContainerView = (viewController as! CitySearchResultsViewController).searchResultsContainerView
    
    let interactor: CitySearchResultsInteractor = CitySearchResultsInteractorImp(weatherProvider: defaultWeatherProvider(), cityProvider: defaultCityProvider())
    let router: CitySearchResultsRouter = CitySearchResultsRouterImp(viewController: viewController, searchResultsContainerView: searchResultsContainerView)
    let presenter: CitySearchResultsPresenter = CitySearchResultsPresenterImp(interactor: interactor, router: router)

    viewController.retainObject(presenter)
    
    presenter.loadContent(forSearchMatch: text)
    
    return viewController
}
