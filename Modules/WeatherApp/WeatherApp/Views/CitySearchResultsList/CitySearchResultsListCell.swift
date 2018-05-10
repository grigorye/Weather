//
//  CitySearchResultsListCell.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol CitySearchResultsItemView : class {
    
    var model: CitySearchResultsItemViewModel! { get set }
}
    
class CitySearchResultsListCell : UITableViewCell, CitySearchResultsItemView {
    
    var model: CitySearchResultsItemViewModel! {
        didSet {
            textLabel!.text = model.cityName
        }
    }
}
