//
//  CitySearchResultsListCell.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

protocol CitySearchResultsItemView : class {
    
    var item: CitySearchResultsItem! { get set }
}
    
class CitySearchResultsListCell : UITableViewCell, CitySearchResultsItemView {
    
    var item: CitySearchResultsItem! {
        didSet {
            textLabel!.text = item.cityName
        }
    }
}
