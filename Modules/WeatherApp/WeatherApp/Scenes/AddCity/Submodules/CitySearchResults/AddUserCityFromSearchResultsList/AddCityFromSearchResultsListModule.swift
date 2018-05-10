//
//  AddCityFromSearchResultsListModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

func newSearchResultsListViewController(_ searchResults: [CityInfo]) -> UIViewController {
    
    let storyboard = UIStoryboard(name: "CitySearchResultsList", bundle: .current)
    let viewController = storyboard.instantiateInitialViewController()!
    let view = viewController as! CitySearchResultsListView
    
    let userCitiesProvider: UserCitiesProvider = defaultUserCitiesProvider()
    
    let interactor = AddCityFromSearchResultsListInteractorImp(userCitiesProvider: userCitiesProvider)
    let router = AddCityFromSearchResultsListRouterImp(viewController: viewController)
    let presenter: AddCityFromSearchResultsListPresenter = AddCityFromSearchResultsListPresenterImp(view: view, interactor: interactor, router: router, searchResults: searchResults)
    
    view.delegate = presenter
    viewController.retainObject(presenter)
    
    presenter.loadContent()
    
    return viewController
}
