//
//  SearchResultsInteractor.swift
//  WeatherApp
//
//  Created by Grigory Entin on 07/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol CitySearchResultsInteractor : CitySearchResultsConsumer {
    
    var listView: CitySearchResultsListView! { get set }
    var view: CitySearchResultsView! { get set }
}

class CitySearchResultsInteractorImp : CitySearchResultsInteractor {
    
    weak var view: CitySearchResultsView!

    var listView: CitySearchResultsListView!
    
    var searchResults: CitySearchResults! {
        didSet {
            configureView()
        }
    }
    
    private func updateViewState() {
        let newState: CitySearchResultsViewState
        switch searchResults {
        case nil:
            newState = .loading
        case .cities?:
            newState = .list
        case .error(let error)?:
            newState = .error(error)
        }
        view.state = newState
    }
    
    private func configureView() {
        switch searchResults {
        case .cities(let cityInfos)?:
            listView.searchResults = cityInfos
        default: ()
        }
        
        updateViewState()
    }
}
