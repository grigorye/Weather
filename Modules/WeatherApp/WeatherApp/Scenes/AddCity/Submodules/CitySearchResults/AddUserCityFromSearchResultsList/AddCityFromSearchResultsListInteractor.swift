//
//  AddCityFromSearchResultsListInteractor.swift
//  WeatherApp
//
//  Created by Grigory Entin on 09/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation.NSDate

protocol AddCityFromSearchResultsListInteractor {
    
    func addCity(with: CityInfo)
}

class AddCityFromSearchResultsListInteractorImp : AddCityFromSearchResultsListInteractor {
    
    let userCitiesProvider: UserCitiesProvider
    
    init(userCitiesProvider: UserCitiesProvider) {
        
        self.userCitiesProvider = userCitiesProvider
    }
    
    // MARK: - <AddCityFromSearchResultsListInteractor>
    
    func addCity(with cityInfo: CityInfo) {

        let userCity = UserCity(with: .cityId(cityInfo.cityId), cityName: cityInfo.cityName)
        try! userCitiesProvider.add(userCity)
    }
    
    // MARK: -
    
    deinit {()}
}
