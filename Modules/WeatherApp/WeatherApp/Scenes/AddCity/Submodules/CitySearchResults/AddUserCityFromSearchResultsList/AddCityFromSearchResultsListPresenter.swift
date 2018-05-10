//
//  AddedCitySearchResultsListPresenter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 08/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol AddCityFromSearchResultsListPresenter : CitySearchResultsListViewDelegate {
    
    func loadContent()
}

class AddCityFromSearchResultsListPresenterImp : AddCityFromSearchResultsListPresenter {

    let view: CitySearchResultsListView
    let interactor: AddCityFromSearchResultsListInteractor
    let router: AddCityFromSearchResultsListRouter
    let searchResults: [CityInfo]
    
    init(view: CitySearchResultsListView, interactor: AddCityFromSearchResultsListInteractor, router: AddCityFromSearchResultsListRouter, searchResults: [CityInfo]) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.searchResults = searchResults
    }

    func loadContent() {
        view.searchResults = searchResults.map { $0.searchResultsItemViewModel }
    }
    
    func didSelectCity(for viewModel: CitySearchResultsItemViewModel) {
        interactor.addCity(with: .init(viewModel))
        router.routeToAddedCity()
    }
}

extension CityInfo {
    
    fileprivate var searchResultsItemViewModel: CitySearchResultsItemViewModel {
        return CitySearchResultsItemViewModel(cityName: cityName, userInfo: self)
    }
    
    init(_ viewModel: CitySearchResultsItemViewModel) {
        self = viewModel.userInfo! as! CityInfo
    }
}
