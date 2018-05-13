//
//  CityZipSearchResultsModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

func newCityZipSearchResultsViewController(for text: String, selectionHandler: (CityInfo) -> Void) -> UIViewController {
    
    return CityZipSearchResultsModule.newViewController(for: text, selectionHandler: selectionHandler)
}

enum CityZipSearchResultsModule : ModuleStoryboarding {
    
    static func prepare(_ viewController: UIViewController, for text: String, selectionHandler: (CityInfo) -> Void) {
    }
    
    static func newViewController(for text: String, selectionHandler: (CityInfo) -> Void) -> UIViewController {
        
        let viewController = instantiateViewController()
        
        prepare(viewController, for: text, selectionHandler: selectionHandler)
        
        return viewController
    }
    
    // MARK: -
    
    typealias View = ()
    typealias Interactor = ()
    typealias Presenter = ()
    typealias Router = ()
    typealias ViewController = CityZipSearchResultsViewController
    
    static let storyboardName = "CityZipSearchResults"
}
