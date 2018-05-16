//
//  CitySearchResultsListModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

extension CitySearchResultsListViewController : CitySearchResultsListView {}

func newCitySearchResultsListViewController(_ searchResults: [CityInfo], selectionHandler: @escaping (CityInfo) -> Void) -> UIViewController {
    
    let storyboard = UIStoryboard(name: "CitySearchResultsList", bundle: .current)
    let viewController = storyboard.instantiateInitialViewController()!
    let view = viewController as! CitySearchResultsListView
    
    let router = CitySearchResultsListRouterImp(viewController: viewController, selectionHandler: selectionHandler)
    let presenter: CitySearchResultsListPresenter = CitySearchResultsListPresenterImp(view: view, router: router, searchResults: searchResults)
    
    view.delegate = presenter
    viewController.retainObject(presenter)
    
    presenter.loadContent()
    
    return viewController
}
