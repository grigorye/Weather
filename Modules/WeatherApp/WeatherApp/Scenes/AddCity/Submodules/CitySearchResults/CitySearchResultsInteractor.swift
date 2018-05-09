//
//  SearchResultsInteractor.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol CitySearchResultsInteractor {
    
    func queryCity(matching text: String, completion: @escaping (CityQueryResult) -> Void)
}

class CitySearchResultsInteractorImp : CitySearchResultsInteractor {
    
    // MARK: - <CitySearchResultsInteractor>
    
    func queryCity(matching text: String, completion: @escaping (CityQueryResult) -> Void) {
        
        self.disposableCityQuery = cityProvider.queryCity(matching: text, completion: completion)
    }
    
    // MARK: -
    
    init(weatherProvider: WeatherProvider, cityProvider: CityProvider) {
        
        self.weatherProvider = weatherProvider
        self.cityProvider = cityProvider
    }
    
    // MARK: -
    
    private let weatherProvider: WeatherProvider
    private let cityProvider: CityProvider
    
    private var disposableCityQuery: CityProvider.DisposableQuery!
    
    // MARK: -
    
    deinit {()}
}
