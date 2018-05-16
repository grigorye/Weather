//
//  CitySearchResultsListPresenter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 08/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol CitySearchResultsListPresenter : CitySearchResultsListViewDelegate {
    
    func loadContent()
}

class CitySearchResultsListPresenterImp : CitySearchResultsListPresenter {

    let view: CitySearchResultsListView
    let router: CitySearchResultsListRouter
    let searchResults: [CityInfo]
    
    init(view: CitySearchResultsListView, router: CitySearchResultsListRouter, searchResults: [CityInfo]) {
        self.view = view
        self.router = router
        self.searchResults = searchResults
    }

    func loadContent() {
        view.searchResults = searchResults.map { $0.searchResultsItem }
    }
    
    func didSelectCity(for item: CitySearchResultsItem) {
        router.routeToSelectedCity(.init(item))
    }
}

extension CityInfo {
    
    fileprivate var searchResultsItem: CitySearchResultsItem {
        return .init(cityName: cityName, userInfo: self)
    }
    
    init(_ item: CitySearchResultsItem) {
        self = item.userInfo! as! CityInfo
    }
}
