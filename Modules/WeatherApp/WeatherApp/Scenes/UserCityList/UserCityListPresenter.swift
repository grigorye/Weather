//
//  UserCityListPresenter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Foundation.NSUnit

protocol UserCityListPresenter : UserCityListViewDelegate {
    
    func loadContent()
}

var defaultTemperatureUnit: UnitTemperature {
    return .celsius
}

func temperatureTextFromWeather(_ weather: WeatherInfo?, temperatureUnit: UnitTemperature) -> String {

    guard let weather = weather else {
        return "."
    }

    let temperatureValue = weather.temperature.converted(to: temperatureUnit).value
    let temperatureString = NumberFormatter.localizedString(from: .init(value: temperatureValue), number: .none)
    return String(format: NSLocalizedString("%@%@", comment: ""), temperatureString, temperatureUnit.symbol)
}

// MARK: -

extension UserCityListItemViewModel {
    
    init(_ userCityWithWeather: UserCityWithWeather, temperatureUnit: UnitTemperature) {
        let (userCity, weather) = userCityWithWeather
        self.cityName = userCity.cityName
        self.temperature = temperatureTextFromWeather(weather, temperatureUnit: temperatureUnit)
        self.identifier = "\(userCity.location)" // !!!
        self.userInfo = userCityWithWeather
    }
    
    var userCityWithWeather: UserCityWithWeather {
        return self.userInfo as! UserCityWithWeather
    }
}

extension UserCity {
    
    init(from viewModel: UserCityListItemViewModel) {
        self = (viewModel.userInfo as! UserCityWithWeather).userCity
    }
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
    
    private var loadedWeatherRefresher: (() -> Void)!

    // MARK: - <UserCityListPresenter>
    
    func loadContent() {
        let (userCitiesWithWeather, weatherRefresher) = interactor.userCitiesWithWeatherAndRefresher()
        
        var refreshing = false
        view.itemViewModels =
            userCitiesWithWeather
                .do(onNext: { [weak self] (_) in
                    refreshing.toggle()
                    if refreshing {
                        self?.view.beginRefreshing()
                    } else {
                        self?.view.endRefreshing()
                    }
                })
                .map({
                    $0.map {
                        UserCityListItemViewModel($0, temperatureUnit: .celsius)
                    }
                })
        
        self.loadedWeatherRefresher = weatherRefresher
    }
    
    // MARK: - <UserCityListViewDelegate>
    
    func selectedAddCity() {
        router.routeToAddCity()
    }
    
    func deleted(_ viewModel: UserCityListItemViewModel) {
        interactor.delete(.init(from: viewModel))
    }
    
    func selected(_ viewModel: UserCityListItemViewModel) {
        router.routeToUserCityWithWeather(viewModel.userCityWithWeather)
    }
    
    func triggeredRefresh() {
        loadedWeatherRefresher()
    }
}
