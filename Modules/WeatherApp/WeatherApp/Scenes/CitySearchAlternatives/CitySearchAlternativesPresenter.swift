//
//  CitySearchAlternativesPresenter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol CitySearchAlternativesPresenter : CitySearchAlternativesViewDelegate {
    
}

class CitySearchAlternativesPresenterImp : CitySearchAlternativesPresenter {
    
    let router: CitySearchAlternativesRouter
    
    init(router: CitySearchAlternativesRouter) {
        self.router = router
    }
    
    // MARK: - <CitySearchAlternativesPresenter>
    
    func selectedCurrentLocation() {
        router.routeOnSelectedCurrentLocation()
    }
    
    func selectedSelectOnMap() {
        router.routeToCitySelectionOnMap()
    }
}
