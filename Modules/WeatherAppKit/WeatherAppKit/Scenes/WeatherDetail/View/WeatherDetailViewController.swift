//
//  DetailViewController.swift
//  Weather
//
//  Created by Grigory Entin on 03/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import UIKit

class WeatherDetailViewController : UIViewController, WeatherDetailView {

    // MARK: - <WeatherDetailView>
    
    var model: WeatherDetailViewModel! {
        didSet {
            configureView()
        }
    }

    // MARK: -
    
    func configureView() {
        detailTableView.model = model
        detailMapView.model = model
        self.title = model.title
    }
    
    // MARK: -
    
    private var detailTableView: WeatherDetailView {
        _ = view
        return _detailTableView
    }
    
    private var _detailTableView: WeatherDetailView!
    
    private var detailMapView: WeatherDetailView {
        _ = view
        return _detailMapView
    }
    
    private var _detailMapView: WeatherDetailView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "detailTable":
            _detailTableView = forceCasted(segue.destination)
        case "detailMap":
            _detailMapView = forceCasted(segue.destination)
        default: ()
        }
    }
    
    // MARK: -
    
    deinit {()}
}
