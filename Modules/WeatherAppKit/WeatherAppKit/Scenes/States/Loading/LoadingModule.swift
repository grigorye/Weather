//
//  LoadingModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

func newLoadingStateViewController() -> UIViewController {
    
    let storyboard = UIStoryboard(name: "Loading", bundle: .current)
    
    let viewController = storyboard.instantiateInitialViewController()!
    
    return viewController
}
