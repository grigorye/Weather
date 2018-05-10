//
//  CityListCell.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit
import Differentiator

struct UserCityListItemViewModel {
    
    let cityName: String
    let temperature: String
    
    let identifier: String
    let userInfo: Any!
}

extension UserCityListItemViewModel : Equatable {}

func == (lhs: UserCityListItemViewModel, rhs: UserCityListItemViewModel) -> Bool {
    return (lhs.identifier == rhs.identifier) && (lhs.temperature == rhs.temperature)
}

extension UserCityListItemViewModel : IdentifiableType {
    
    typealias Identity = String
    
    var identity: String {
        return identifier
    }
}

protocol UserCityListItemView : class {
    
    var model: UserCityListItemViewModel! { get set }
}

class UserCityListCell : UITableViewCell, UserCityListItemView {
    
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var cityNameLabel: UILabel!

    // MARK: - <UserCityListItemView>
    
    var model: UserCityListItemViewModel! {
        didSet {
            cityNameLabel.text = model.cityName
            temperatureLabel.text = model.temperature
        }
    }
}
