//
//  MainContainerView.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit.UINavigationController

protocol MainContainerView : ContainerView {
    
    var masterNavigationController: UINavigationController { get }
    var detailNavigationController: UINavigationController { get }
}
