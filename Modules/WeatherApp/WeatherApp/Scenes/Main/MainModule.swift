//
//  MainModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

func newMainViewController() -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: .current)
    
    let viewController = storyboard.instantiateInitialViewController()!
    
    return viewController
}
