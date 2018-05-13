//
//  DetailViewController.swift
//  Weather
//
//  Created by Grigory Entin on 03/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

class WeatherDetailViewController : UIViewController, WeatherDetailView {

    deinit {()}

    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView() {
        guard nil != viewIfLoaded else {
            return
        }
        detailDescriptionLabel.text = model.temperature
    }
    
    // MARK: -
    
    @IBOutlet private var detailDescriptionLabel: UILabel!

    // MARK: - <WeatherDetailView>
    
    var model: WeatherDetailViewModel! {
        didSet {
            configureView()
        }
    }
}
