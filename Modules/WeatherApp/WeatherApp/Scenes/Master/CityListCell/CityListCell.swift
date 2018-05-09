//
//  CityListCell.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

class CityListCell : UITableViewCell, CityView {
    
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var cityNameLabel: UILabel!

    var model: CityViewModel! {
        didSet {
            temperatureLabel.text = model.temperature
            cityNameLabel.text = model.city
        }
    }
}
