//
//  AddCityInteractor.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

enum CitySearchResults {
    
    case cities([CityInfo])
    case error(Error)
}

protocol CitySearchResultsConsumer : class {
    
    var searchResults: CitySearchResults! { get set }
}

protocol AddCityInteractor : CitySearchInputDelegate {
    
    var weatherProvider: WeatherProvider! { get set }
    var citySearchResultsConsumer: CitySearchResultsConsumer! { get set }
}

class AddCityInteractorImp : AddCityInteractor {
    
    init() {()}
    deinit {()}
    
    var weatherProvider: WeatherProvider! = defaultWeatherProvider()
    var cityProvider: CityProvider! = defaultCityProvider()
    var citySearchResultsConsumer: CitySearchResultsConsumer!
    var cityQuery: CityProvider.DisposableQuery!

    /// MARK: - CitySearchInputDelegate
    
    func citySearchInputDidChange(_ text: String) {
        let citySearchResultsConsumer = self.citySearchResultsConsumer!
        
        citySearchResultsConsumer.searchResults = nil
        self.cityQuery = nil
        guard !text.isEmpty else {
            return
        }
        self.cityQuery = cityProvider.queryCity(matching: text) { (cityQueryResult) in
            let searchResults: CitySearchResults
            switch cityQueryResult {
            case .failure(let error):
                searchResults = .error(error)
            case .success(let cityInfos):
                searchResults = .cities(cityInfos)
            }
            citySearchResultsConsumer.searchResults = searchResults
        }
    }
}
