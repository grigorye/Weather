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

    init(interactor: CitySearchResultsInteractor, router: CitySearchResultsRouter) {
        
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - <CitySearchResultsPresenter>
    
    func loadContent(forSearchMatch text: String) {
        
        router.routeToLoading()
        interactor.queryCity(matching: text) { [router] (result) in
            switch result {
            case .failure(let error):
                router.routeToError(error)
            case .success(let cityInfos):
                router.routeToList(cityInfos)
            }
        }
    }
}
