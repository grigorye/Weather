//
//  AddCityInteractor.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation

protocol AddCityInteractor {
    
    func add(userCityFor cityInfo: CityInfo)
    func add(userCityFor coordinate: CityCoordinate)
    func addUserCityForCurrentLocation()
}

class AddCityInteractorImp : AddCityInteractor {
    
    let userCitiesProvider: UserCitiesProvider
    
    init(userCitiesProvider: UserCitiesProvider) {
        
        self.userCitiesProvider = userCitiesProvider
    }
    
    // MARK: - <AddCityInteractor>
    
    func add(userCityFor cityInfo: CityInfo) {
        
        let userCity = UserCity(
            with: .cityId(cityInfo.cityId),
            cityName: cityInfo.cityName
        )
    
        try! userCitiesProvider.add(userCity)
    }

    func add(userCityFor coordinate: CityCoordinate) {
        
        let cityName = String(format: "%.5f,%.5f", coordinate.latitude, coordinate.longitude)
        let userCity = UserCity(
            with: .coordinate(coordinate),
            cityName: cityName
        )
        
        try! userCitiesProvider.add(userCity)
    }

    func addUserCityForCurrentLocation() {
        
        let userCity = UserCity(
            with: .currentLocation,
            cityName: NSLocalizedString("Current Location", comment: "")
        )
        
        try! userCitiesProvider.add(userCity)
    }
}
