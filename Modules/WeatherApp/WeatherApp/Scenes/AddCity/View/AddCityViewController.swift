//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

class AddCityViewController : ModuleViewController {
    
    var presenter: AddCityPresenter!
    
    override func presenterDidLoad() {
        
        super.presenterDidLoad()
        
        childSearchInputView.delegate = presenter!
    }
    
    @IBOutlet var searchResultsContainerView: UIStackView!
    
    var childSearchInputView: CitySearchInputView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case "searchInput":
            childSearchInputView = forceCasted(segue.destination)
        default: ()
        }
    }
}
