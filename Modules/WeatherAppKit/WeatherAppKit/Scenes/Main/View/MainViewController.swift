//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

class MainViewController : UISplitViewController {
    
    // MARK: - <MainContainerView>
    
    var masterNavigationController: UINavigationController {
        _ = view
        return forceCasted(viewControllers[0])
    }
    
    var detailNavigationController: UINavigationController {
        _ = view
        return forceCasted(viewControllers[1])
    }
    
    // MARK: -
    
    deinit {()}
}
