//
//  UserCityListPresenter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift
import Foundation.NSUnit

protocol UserCityListPresenter : UserCityListViewDelegate {
    
    func loadContent()
}

// MARK: -

class UserCityListPresenterImp : UserCityListPresenter {
    
    let view: UserCityListView
    let interactor: UserCityListInteractor
    let router: UserCityListRouter
    
    init(view: UserCityListView, interactor: UserCityListInteractor, router: UserCityListRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    deinit {()}
    
    let disposeBag = DisposeBag()
    
    // MARK: - <UserCityListPresenter>
    
    func loadContent() {
        interactor.clearRefreshingForUserCities()
        view.itemViewModels =
            interactor.observableUserCities
                .map { [interactor] (userCities) in
                    return dump(userCities, name: "userCities", maxDepth: 0).map { (userCity) in
                        let lastWeather = interactor.lastWeather(for: userCity)
                        return UserCityListItemViewModel(
                            userCity,
                            lastWeather: lastWeather,
                            temperatureUnit: defaultTemperatureUnit,
                            dateFormatter: defaultTimeFormatter
                        )
                    }
                }
        interactor.refreshUserCities()
        interactor.observableUserCities.subscribe(onNext: { [interactor] (userCities) in
            let newCities = userCities.filter { nil == $0.dateWeatherRequested && nil == $0.dateWeatherUpdated }
            interactor.refreshUserCities(dump(newCities, name: "newCities", maxDepth: 0))
        }).disposed(by: disposeBag)
    }
    
    // MARK: - <UserCityListViewDelegate>
    
    func deleted(_ viewModel: UserCityListItemViewModel) {
        interactor.delete(.init(from: viewModel))
    }
    
    func selected(_ viewModel: UserCityListItemViewModel) {
        router.routeToUserCityWithLastWeather((viewModel.userCity, viewModel.lastWeather))
    }
    
    func triggeredRefresh() {
        interactor.refreshUserCities()
        view.endRefreshing()
    }
}
