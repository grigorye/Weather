//
//  AppModule.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit
import WeatherAppKit

func newAppWindow() -> UIWindow {
    let window = UIWindow(frame: UIScreen.main.bounds)
    let mainViewController = WeatherAppKit.newMainViewController()
    window.rootViewController = mainViewController
    return window
}
