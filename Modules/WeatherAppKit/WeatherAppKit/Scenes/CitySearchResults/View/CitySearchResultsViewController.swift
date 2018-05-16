//
//  CitySearchResultsViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

class CitySearchResultsViewController : UIViewController, CitySearchResultsContainerView {
    
    @IBOutlet private var _searchResultsSuperview: UIStackView!
    
    var searchResultsSuperview: UIStackView {
        _ = view
        return _searchResultsSuperview
    }
}
