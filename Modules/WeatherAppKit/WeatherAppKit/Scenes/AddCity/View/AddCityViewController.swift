//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

class AddCityViewController : UIViewController {
    
    deinit {()}
    
    // MARK: - <AddCityContainerView>
    
    var searchContainerView: UIStackView {
        _ = view
        return _searchContainerView
    }
    
    // MARK: -
    
    @IBOutlet private var _searchContainerView: UIStackView!
}
