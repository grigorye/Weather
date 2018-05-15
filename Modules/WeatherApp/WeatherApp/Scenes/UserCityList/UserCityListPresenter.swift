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
    
    var lastWeatherInfo: LastWeatherInfo {
        var result: LastWeatherInfo!
        let disposeBag = DisposeBag()
        self.lastWeather.subscribe(onNext: {
            result = $0
        }).disposed(by: disposeBag)
        return result!
    }
}

struct LastWeatherInfo {
    let requestDate: Date?
    let updateDate: Date?
    let errored: Bool
    let weather: WeatherInfo?
}

extension UserCity {
    var lastWeatherInfo: LastWeatherInfo {
        return .init(
            requestDate: self.dateWeatherRequested,
            updateDate: self.dateWeatherUpdated,
            errored: self.errored,
            weather: self.weather
        )
    }
}
typealias LastWeather = Observable<LastWeatherInfo>

func defaultTimeFormatter(_ date: Date) -> String {
    
    return DateFormatter.localizedString(from: date, dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.short)
}

extension UserCityListItemViewModel {
    
    init(_ userCity: UserCity, lastWeather: LastWeather, temperatureUnit: UnitTemperature, dateFormatter: @escaping (Date) -> String) {
        self.identifier = "\(userCity.location)" // !!!
        self.icon = {
            switch userCity.location {
            case .cityId:
                return nil
            case .coordinate:
                return #imageLiteral(resourceName: "icons8-map_marker")
            case .currentLocation:
                return #imageLiteral(resourceName: "icons8-near_me")
            }
        }()

        self.temperatureUnit = temperatureUnit
        self.lastWeatherModel = lastWeather.map { (lastWeatherInfo) in
            let weather = lastWeatherInfo.weather
            let temperature = temperatureTextFromWeather(weather, temperatureUnit: temperatureUnit)
            let cityName = weather?.cityName ?? "..."
            let subtitle = weather.flatMap { dateFormatter($0.dateReceived) } ?? userCity.cityName
            return UserCityListItemWeatherViewModel(
                subtitle: subtitle,
                temperature: temperature,
                cityName: cityName,
                textColor: {
                    if userCity.hasWeatherQueryInProgress {
                        return .blue
                    }
                    if lastWeatherInfo.errored {
                        return .red
                    }
                    if nil == lastWeatherInfo.updateDate {
                        return .gray
                    }
                    return .black
                }()
            )
        }
        self.userInfo = UserCityWithLastWeather(userCity, lastWeather)
    }
    
    var lastWeather: LastWeather {
        return self.userCityWithLastWeather.lastWeather
    }
    
    var userCity: UserCity {
        return self.userCityWithLastWeather.userCity
    }

    var userCityWithLastWeather: UserCityWithLastWeather {
        return self.userInfo as! UserCityWithLastWeather
    }
}

extension UserCity {
    
    init(from viewModel: UserCityListItemViewModel) {
        self = (viewModel.userInfo as! UserCityWithLastWeather).userCity
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
    
    // MARK: - <UserCityListPresenter>
    
    func loadContent() {
        view.itemViewModels =
            interactor.observableUserCities
                .map { [interactor] (userCities) in
                    return dump(userCities).map { (userCity) in
                        let lastWeather = interactor.lastWeather(for: userCity)
                        return UserCityListItemViewModel(
                            userCity,
                            lastWeather: lastWeather,
                            temperatureUnit: defaultTemperatureUnit,
                            dateFormatter: defaultTimeFormatter
                        )
                    }
                }
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
