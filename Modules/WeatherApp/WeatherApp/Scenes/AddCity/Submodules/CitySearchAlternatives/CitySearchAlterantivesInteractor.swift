//
//  CitySearchAlterantivesInteractor.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation

protocol CitySearchAlternativesInteractor {
    
    func addCityForCurrentLocation()
}

class CitySearchAlternativesInteractorImp : CitySearchAlternativesInteractor {
    
    let userCitiesProvider: UserCitiesProvider
    
    init(userCitiesProvider: UserCitiesProvider) {
        
        self.userCitiesProvider = userCitiesProvider
    }
    
    // MARK: - <CitySearchAlternativesInteractor>
    
    func addCityForCurrentLocation() {
        let userCity = UserCity(
            with: .currentLocation,
            cityName: NSLocalizedString("Current Location", comment: "")
        )
        try! userCitiesProvider.add(userCity)
    }
}
