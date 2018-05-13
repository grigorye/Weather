//
//  CitySearchInputInteractor.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

enum CitySearchInputType : Int {

    case cityName
    case zipCode
}

protocol CitySearchInputInteractor : class {
    
    var currentInputType: CitySearchInputType { get set }
}

class CitySearchInputInteractorImp : CitySearchInputInteractor {
    
    // MARK: - <CitySearchInputInteractor>
    
    var currentInputType: CitySearchInputType = .cityName
}
