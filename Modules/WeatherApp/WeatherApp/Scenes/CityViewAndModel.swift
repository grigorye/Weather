//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

struct CityViewModel {

    var city: String
    var temperature: String
}

protocol CityView : class {
    
    var model: CityViewModel! { get set }
}
