//
//  CitySelectionOnMapPresenter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol CitySelectionOnMapPresenter : CitySelectionOnMapViewDelegate {
}

class CitySelectionOnMapPresenterImp : CitySelectionOnMapPresenter {
    
    let interactor: CitySelectionOnMapInteractor
    let router: CitySelectionOnMapRouter
    
    init(interactor: CitySelectionOnMapInteractor, router: CitySelectionOnMapRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - <CitySelectionOnMapPresenter>
    
    func didSelect(_ coordinate: CityCoordinate) {
        interactor.add(userCityFor: coordinate)
        router.routeOnSelect()
    }
    
    func didCancel() {
        router.routeOnCancel()
    }
}
