//
//  CitySearchResultsContainerView.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol CitySearchResultsContainerView : ContainerView {
    
    var searchResultsSuperview: UIStackView { get }
}
