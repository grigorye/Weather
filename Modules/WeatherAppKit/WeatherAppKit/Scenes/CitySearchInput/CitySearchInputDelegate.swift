//
//  CitySearchInputDelegate.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol CitySearchInputDelegate : class {
    
    func citySearchInputDidChange(_ text: String, type: CitySearchInputType)
    
    func citySearchInputDidCancel()
}
