//
//  AddCityPresenter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 08/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol AddCityPresenter : CitySearchInputViewDelegate {
}

class AddCityPresenterImp : AddCityPresenter {
    
    let router: AddCityRouter
    let interactor: AddCityInteractor
    
    init(interactor: AddCityInteractor, router: AddCityRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - <CitySearchInputDelegate>
    
    func citySearchInputDidChange(_ text: String) {
        
        if text.isEmpty {
            router.routeToNoSearch()
        } else {
            router.routeToSearch(for: text)
        }
    }
    
    // MARK: -
    
    deinit {()}
}
