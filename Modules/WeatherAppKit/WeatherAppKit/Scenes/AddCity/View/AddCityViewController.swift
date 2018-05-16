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
    
    var searchInputViewController: UIViewController {
        _ = view
        return _searchInputViewController
    }
    
    // MARK: -
    
    @IBOutlet private var _searchContainerView: UIStackView!
    
    private var _searchInputViewController: UIViewController!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case "searchInput":
            _searchInputViewController = segue.destination
        default: ()
        }
    }
}
