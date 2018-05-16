//
//  CitySearchResultsListView.swift
//  WeatherApp
//
//  Created by Grigory Entin on 13/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

struct CitySearchResultsItem {
    
    let cityName: String
    let userInfo: Any!
}

protocol CitySearchResultsListView : class {
    
    var delegate: CitySearchResultsListViewDelegate! { get set }
    var searchResults: [CitySearchResultsItem] { get set }
}

protocol CitySearchResultsListViewDelegate : class {
    
    func didSelectCity(for: CitySearchResultsItem)
}
