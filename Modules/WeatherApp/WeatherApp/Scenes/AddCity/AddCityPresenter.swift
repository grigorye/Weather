//
//  AddCityPresenter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 12/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol AddCityPresenter : CitySearchInputViewDelegate {

    func cityInfoSelectionHandler(_ cityInfo: CityInfo)
    func coordinateSelectionHandler(_ coordinate: CityCoordinate)
    func currentLocationSelectionHandler()
}

class AddCityPresenterImp : AddCityPresenter {

    let router: AddCityRouter
    let interactor: AddCityInteractor

    init(router: AddCityRouter, interactor: AddCityInteractor) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: - <AddCityPresenter>
    
    func cityInfoSelectionHandler(_ cityInfo: CityInfo) {
        interactor.add(userCityFor: cityInfo)
        router.routeToAddedCity()
    }
    
    func coordinateSelectionHandler(_ coordinate: CityCoordinate) {
        interactor.add(userCityFor: coordinate)
        router.routeToAddedCity()
    }
    
    func currentLocationSelectionHandler() {
        interactor.addUserCityForCurrentLocation()
        router.routeToAddedCity()
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
