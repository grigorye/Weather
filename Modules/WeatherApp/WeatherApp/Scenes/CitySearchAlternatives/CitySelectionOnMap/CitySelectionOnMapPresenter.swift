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
    
    let router: CitySelectionOnMapRouter
    
    init(router: CitySelectionOnMapRouter) {
        self.router = router
    }
    
    // MARK: - <CitySelectionOnMapPresenter>
    
    func didSelect(_ coordinate: CityCoordinate) {
        router.routeOnSelect(coordinate)
    }
    
    func didCancel() {
        router.routeOnCancel()
    }
}
