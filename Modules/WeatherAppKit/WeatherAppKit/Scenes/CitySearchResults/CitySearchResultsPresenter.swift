//
//  CitySearchResultsPresenter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 08/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol CitySearchResultsPresenter : class {

    func loadContent(forSearchMatch text: String)
}

class CitySearchResultsPresenterImp : CitySearchResultsPresenter {
    
    let interactor: CitySearchResultsInteractor
    let router: CitySearchResultsRouter
    let selectionHandler: (CityInfo) -> Void

    init(interactor: CitySearchResultsInteractor, router: CitySearchResultsRouter, selectionHandler: @escaping (CityInfo) -> Void) {
        
        self.interactor = interactor
        self.router = router
        self.selectionHandler = selectionHandler
    }
    
    // MARK: - <CitySearchResultsPresenter>
    
    func loadContent(forSearchMatch text: String) {
        
        router.routeToLoading()
        interactor.queryCity(matching: text) { [selectionHandler, router] (result) in
            switch result {
            case .failure(let error):
                router.routeToError(error)
            case .success(let cityInfos):
                router.routeToList(cityInfos, selectionHandler: selectionHandler)
            }
        }
    }
}
