//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol CitySearchResultsConsumerProvider {
    
    var citySearchResultsConsumer: CitySearchResultsConsumer { get }
}

class AddCityViewController : UIViewController {
    
    var interactor: AddCityInteractor! = AddCityInteractorImp()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier {
        case "citySearchInput":
            (segue.destination as! CitySearchInputProvider).delegate = interactor
        case "citySearchResults":
            interactor.citySearchResultsConsumer = (segue.destination as! CitySearchResultsConsumerProvider).citySearchResultsConsumer
        default: ()
        }
    }
}
