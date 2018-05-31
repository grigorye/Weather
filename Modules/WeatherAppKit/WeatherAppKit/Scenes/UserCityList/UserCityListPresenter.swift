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
    
    unowned let view: UserCityListView
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
        interactor.clearRefreshingForUserCityLocations()
        view.itemViewModels =
            interactor.observableUserCityInfos
                .map { [interactor] (userCityInfos) in
                    return dump(userCityInfos, name: "userCityInfos", maxDepth: 0).map { (userCityInfo) in
                        let lastWeather = interactor.lastWeather(for: userCityInfo.location)
                        return UserCityListItemViewModel(
                            userCityInfo,
                            lastWeather: lastWeather,
                            temperatureUnit: defaultTemperatureUnit,
                            dateFormatter: defaultTimeFormatter
                        )
                    }
                }
        interactor.refreshUserCityLocations()
        interactor.observableUserCityInfos.subscribe(onNext: { [interactor] (userCityInfos) in
            let locations = userCityInfos.map { $0.location }
            let newLocations = locations.filter {
                !interactor.weatherIsEverQueried(for: $0)
            }
            interactor.refreshUserCityLocations(dump(newLocations, name: "newLocations", maxDepth: 0))
        }).disposed(by: disposeBag)
    }
    
    // MARK: - <UserCityListViewDelegate>
    
    func deleted(_ viewModel: UserCityListItemViewModel) {
        interactor.delete(viewModel.userCityInfo.location)
    }
    
    func selected(_ viewModel: UserCityListItemViewModel) {
        router.routeToUserCityWithLastWeather(viewModel.userCityInfoAndLastWeather)
    }
    
    func triggeredRefresh() {
        interactor.refreshUserCityLocations()
        view.endRefreshing()
    }
}
