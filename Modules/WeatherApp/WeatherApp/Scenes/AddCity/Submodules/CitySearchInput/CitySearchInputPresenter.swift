//
//  CitySearchInputPresenter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol CitySearchInputPresenter : CitySearchInputViewDelegate {
    
}

class CitySearchInputPresenterImp : CitySearchInputPresenter {

    let router: CitySearchInputRouter
    
    init(router: CitySearchInputRouter) {
        self.router = router
    }
    
    // MARK: - <CitySearchInputViewDelegate>
    
    func citySearchInputDidChange(_ text: String) {
        
        if text.isEmpty {
            router.routeToNoSearch()
        } else {
            router.routeToSearch(for: text)
        }
    }
    
    func citySearchInputDidCancel() {
        router.routeToCancelSearch()
    }
}
