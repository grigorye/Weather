//
//  CitySearchResultsViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

class CitySearchResultsViewController : UIViewController {
    
    @IBOutlet private var _searchResultsContainerView: UIStackView!
    
    var searchResultsContainerView: UIStackView {
        _ = view
        return _searchResultsContainerView
    }
}
