//
//  CitySearchInputModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

extension CitySearchInputViewController : CitySearchInputView {}

enum CitySearchInputModule : ModuleStoryboarding {
    
    typealias View = CitySearchInputView
    typealias ViewController = CitySearchInputViewController
    
    static let storyboardName = "CitySearchInput"
    
    static func bind(_ viewController: UIViewController, viewDelegate: CitySearchInputViewDelegate) {
        
        let view = viewController as! View
        view.delegate = viewDelegate
    }
}
