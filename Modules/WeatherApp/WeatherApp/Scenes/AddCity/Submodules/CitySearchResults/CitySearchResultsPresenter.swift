//
//  CitySearchResultsPresenter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 08/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol CitySearchResultsPresenter {

    func loadContent(forSearchMatch text: String)
}

class CitySearchResultsPresenterImp : CitySearchResultsPresenter {
    
    let view: CitySearchResultsView
    let interactor: CitySearchResultsInteractor

    init(view: CitySearchResultsView, interactor: CitySearchResultsInteractor) {
        
        self.view = view
        self.interactor = interactor
    }
    
    // MARK: - <CitySearchResultsPresenter>
    
    func loadContent(forSearchMatch text: String) {
        
        view.state = .loading
        interactor.queryCity(matching: text) { [view] (result) in
            switch result {
            case .failure(let error):
                view.state = .error(error)
            case .success(let cityInfos):
                view.state = .list(cityInfos)
            }
        }
    }
}
