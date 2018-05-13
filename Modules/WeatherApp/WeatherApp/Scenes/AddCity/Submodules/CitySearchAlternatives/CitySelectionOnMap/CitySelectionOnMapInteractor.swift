//
//  CitySelectionOnMapInteractor.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol CitySelectionOnMapInteractor {
    
    func add(userCityFor coordinate: CityCoordinate)
}

class CitySelectionOnMapInteractorImp : CitySelectionOnMapInteractor {
    
    let userCitiesProvider: UserCitiesProvider
    
    init(userCitiesProvider: UserCitiesProvider) {
        self.userCitiesProvider = userCitiesProvider
    }
    
    // MARK: - <CitySelectionOnMapInteractor>
    
    func add(userCityFor coordinate: CityCoordinate) {
        
        let cityName = String(format: "%.5f,%.5f", coordinate.latitude, coordinate.longitude)
        let userCity = UserCity(with: .coordinate(coordinate), cityName: cityName)
        try! userCitiesProvider.add(userCity)
    }
}
