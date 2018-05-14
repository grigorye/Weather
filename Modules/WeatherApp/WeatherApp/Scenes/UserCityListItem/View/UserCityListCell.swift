//
//  CityListCell.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

class UserCityListCell : UITableViewCell, UserCityListItemView {
    
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!

    // MARK: - <UserCityListItemView>
    
    var model: UserCityListItemViewModel! {
        didSet {
            cityNameLabel.text = model.cityName
            temperatureLabel.text = model.temperature
            subtitleLabel.text = model.subtitle
        }
    }
}
