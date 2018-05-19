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
    
    // MARK: - <AddCityInteractor>
    
    func add(userCityFor cityInfo: CityInfo) {
        
        let userCity = UserCityInfo(
            location: .cityId(cityInfo.cityId),
            cityName: cityInfo.cityName
        )

        self.addUserCity(for: userCity)
    }

    func add(userCityFor coordinate: CityCoordinate) {
        
        let cityName = String(format: "%.5f,%.5f", coordinate.latitude, coordinate.longitude)
        let userCity = UserCityInfo(
            location: .coordinate(coordinate),
            cityName: cityName
        )
        
        self.addUserCity(for: userCity)
    }

    func addUserCityForCurrentLocation() {
        
        let userCity = UserCityInfo(
            location: .currentLocation,
            cityName: NSLocalizedString("Current Location", comment: "")
        )
        
        self.addUserCity(for: userCity)
    }
    
    // MARK: -
    
    func addUserCity(for userCityInfo: UserCityInfo) {
    
        try! userCitiesProvider.addUserCity(with: userCityInfo)
    }
    
    // MARK: -
    
    let userCitiesProvider: UserCitiesProvider
    
    init(userCitiesProvider: UserCitiesProvider) {
        
        self.userCitiesProvider = userCitiesProvider
    }
    
    deinit {()}
}
