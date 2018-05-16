//
//  AddCityContainerView.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit.UIViewController
import UIKit.UIStackView

protocol AddCityContainerView : ContainerView {
    
    var searchInputViewController: UIViewController { get }
    
    var searchContainerView: UIStackView { get }
}
