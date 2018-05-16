//
//  WeatherDetailTableViewController.swift
//  WeatherApp
//
//  Created by Grigory Entin on 14/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

class WeatherDetailTableViewController : UITableViewController, WeatherDetailView {
    
    // MARK: - <WeatherDetailView>
    
    var model: WeatherDetailViewModel! {
        didSet {
            configureView()
        }
    }
    
    // MARK: -
    
    private func configureView() {
        
        temperatureLabel.text = model.temperature
    }
    
    // MARK: -
    
    var temperatureLabel: UILabel {
        _ = view
        return _temperatureLabel
    }
    
    @IBOutlet private var _temperatureLabel: UILabel!

    // MARK: -
    
    deinit {()}
}
