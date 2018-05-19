//
//  UserCityListMocksTests.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 17/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

@testable import WeatherAppKit
import RxSwift

class UserCityListViewMock : UserCityListView {
    
    var delegate: UserCityListViewDelegate!
    
    var itemViewModels_$setCount = 0
    var itemViewModels_$getCount = 0
    var itemViewModels_$: Observable<[UserCityListItemViewModel]>!
    var itemViewModels: Observable<[UserCityListItemViewModel]>! {
        set {
            itemViewModels_$setCount += 1
            itemViewModels_$ = newValue
        }
        get {
            itemViewModels_$getCount += 1
            return itemViewModels_$
        }
    }
    
    func beginRefreshing() {
        fatalError()
    }
    
    var endRefreshing_$invocationCount = 0
    func endRefreshing() {
        endRefreshing_$invocationCount += 1
    }
}

class UserCityListInteractorMock : UserCityListInteractor {
    
    let observableUserCityInfos_$ = BehaviorSubject(value: [UserCityInfo]())
    lazy var observableUserCityInfos_$handler: () -> Observable<[UserCityInfo]> = {
        return self.observableUserCityInfos_$
    }
    var observableUserCityInfos_$invocationCount = 0
    var observableUserCityInfos: Observable<[UserCityInfo]> {
        observableUserCityInfos_$invocationCount += 1
        return observableUserCityInfos_$handler()
    }
    
    var weatherIsEverQueried_$invocationCount = 0
    var weatherIsEverQueried_$: Bool?
    func weatherIsEverQueried(for: UserCityLocation) -> Bool {
        weatherIsEverQueried_$invocationCount += 1
        return weatherIsEverQueried_$!
    }

    var lastWeather_$invocationCount = 0
    var lastWeather_$: LastWeather?
    func lastWeather(for: UserCityLocation) -> LastWeather {
        lastWeather_$invocationCount += 1
        return lastWeather_$!
    }
    
    var refreshUserCityLocations_$invocationCount = 0
    func refreshUserCityLocations() {
        refreshUserCityLocations_$invocationCount += 1
    }
    
    var refreshUserCityLocations__$invocationCount = 0
    func refreshUserCityLocations(_: [UserCityLocation]) {
        refreshUserCityLocations__$invocationCount += 1
    }
    
    var clearRefreshingForUserCityLocations_$invocationCount = 0
    func clearRefreshingForUserCityLocations() {
        clearRefreshingForUserCityLocations_$invocationCount += 1
    }
    
    var delete_$invocationCount = 0
    func delete(_: UserCityLocation) {
        delete_$invocationCount += 1
    }
}

class UserCityListRouterMock : UserCityListRouter {
    
    var routeToUserCityWithLastWeather_$invocationCount = 0
    func routeToUserCityWithLastWeather(_: UserCityInfoAndLastWeather) {
        routeToUserCityWithLastWeather_$invocationCount += 1
    }
}
