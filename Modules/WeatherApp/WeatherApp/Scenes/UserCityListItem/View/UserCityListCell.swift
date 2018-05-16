//
//  CityListCell.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift
import UIKit

class UserCityListCell : UITableViewCell, UserCityListItemView {
    
    // MARK: - <UserCityListItemView>
    
    var modelDisposeBag: DisposeBag!
    var model: UserCityListItemViewModel! {
        didSet {
            iconView.image = model.icon
            
            modelDisposeBag = DisposeBag()
            model.lastWeatherModel
                .subscribe(onNext: { [temperatureLabel, cityNameLabel, subtitleLabel] (model) in
                    subtitleLabel.text = model.subtitle
                    subtitleLabel.textColor = model.textColor
                    temperatureLabel.text = model.temperature
                    temperatureLabel.textColor = model.textColor
                    cityNameLabel.text = model.cityName
                    cityNameLabel.textColor = model.textColor
                }).disposed(by: modelDisposeBag)
        }
    }
    
    // MARK: -
    
    var temperatureLabel: UILabel {
        return _temperatureLabel!
    }
    
    @IBOutlet private var _temperatureLabel: UILabel!
    
    var cityNameLabel: UILabel {
        return _cityNameLabel!
    }
    
    @IBOutlet private var _cityNameLabel: UILabel!
    
    var subtitleLabel: UILabel {
        return _subtitleLabel!
    }

    @IBOutlet private var _subtitleLabel: UILabel!
    
    var iconView: UIImageView {
        return _iconView
    }
    
    @IBOutlet var _iconView: UIImageView!
}
