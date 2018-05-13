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
    
    let interactor: CitySearchAlternativesInteractor
    let router: CitySearchAlternativesRouter
    
    init(interactor: CitySearchAlternativesInteractor, router: CitySearchAlternativesRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - <CitySearchAlternativesPresenter>
    
    func selectedCurrentLocation() {
        interactor.addCityForCurrentLocation()
        router.routeOnAddedCurrentLocation()
    }
    
    func selectedSelectOnMap() {
        router.routeToCitySelectionOnMap()
    }
}
