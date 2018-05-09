//
//  CitySearchResultsModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 09/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

extension CitySearchResultsViewController {
    
    override func loadPresenter() {
        
        super.loadPresenter()
        
        let interactor = CitySearchResultsInteractorImp(weatherProvider: defaultWeatherProvider(), cityProvider: defaultCityProvider())
        let presenter = CitySearchResultsPresenterImp(view: self, interactor: interactor)
        self.presenter = presenter
    }
}

func newCityNoSearchViewController() -> UIViewController {
    
    let storyboard = UIStoryboard(name: "CityNoSearch", bundle: .current)
    return storyboard.instantiateInitialViewController()!
}

func newCitySearchViewController(for text: String) -> UIViewController {
    
    let storyboard = UIStoryboard(name: "CitySearchResults", bundle: .current)
    let viewControllerObject = storyboard.instantiateInitialViewController()!
    let viewController = viewControllerObject as! CitySearchResultsViewController
    viewController.loadViewIfNeeded()
    let presenter = viewController.presenter!
    
    presenter.loadContent(forSearchMatch: text)
    
    return viewController
}
