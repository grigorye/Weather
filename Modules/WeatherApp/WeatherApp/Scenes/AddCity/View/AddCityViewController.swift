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
    
    // MARK: -
    
    var childSearchInputViewController: UIViewController {
        _ = view
        return childSearchInputViewControllerImp
    }
    private var childSearchInputViewControllerImp: UIViewController!
    
    var searchContainerView: UIStackView {
        _ = view
        return searchContainerViewImp
    }
    @IBOutlet private var searchContainerViewImp: UIStackView!
    
    // MARK: -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case "searchInput":
            childSearchInputViewControllerImp = segue.destination
        default: ()
        }
    }
}
