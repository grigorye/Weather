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
    
    let observableUserCities_$: BehaviorSubject<[UserCity]> = BehaviorSubject(value: [UserCity]())
    lazy var observableUserCities_$handler: () -> Observable<[UserCity]> = {
        return self.observableUserCities_$
    }
    var observableUserCities_$invocationCount = 0
    var observableUserCities: Observable<[UserCity]> {
        observableUserCities_$invocationCount += 1
        return observableUserCities_$handler()
    }
    
    var lastWeather_$invocationCount = 0
    var lastWeather_$: LastWeather?
    func lastWeather(for: UserCity) -> LastWeather {
        lastWeather_$invocationCount += 1
        return lastWeather_$!
    }
    
    var refreshUserCities_$invocationCount = 0
    func refreshUserCities() {
        refreshUserCities_$invocationCount += 1
    }
    
    var refreshUserCities__$invocationCount = 0
    func refreshUserCities(_: [UserCity]) {
        refreshUserCities__$invocationCount += 1
    }
    
    var clearRefreshingForUserCities_$invocationCount = 0
    func clearRefreshingForUserCities() {
        clearRefreshingForUserCities_$invocationCount += 1
    }
    
    var delete_$invocationCount = 0
    func delete(_: UserCity) {
        delete_$invocationCount += 1
    }
}

class UserCityListRouterMock : UserCityListRouter {
    
    var routeToUserCityWithLastWeather_$invocationCount = 0
    func routeToUserCityWithLastWeather(_: UserCityWithLastWeather) {
        routeToUserCityWithLastWeather_$invocationCount += 1
    }
}
