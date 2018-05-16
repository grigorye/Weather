//
//  WeatherDetailPresenter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift

protocol WeatherDetailPresenter : class {
    
    func loadContent()
}

class WeatherDetailPresenterImp : WeatherDetailPresenter {
    
    let view: WeatherDetailView
    let userCityWithLastWeather: UserCityWithLastWeather
    
    init(view: WeatherDetailView, userCityWithLastWeather: UserCityWithLastWeather) {
        self.view = view
        self.userCityWithLastWeather = userCityWithLastWeather
    }
    
    let disposeBag = DisposeBag()
    
    func loadContent() {
        let (userCity, lastWeather) = userCityWithLastWeather
        lastWeather.subscribe(onNext: { [view] (lastWeatherInfo) in
            let weather = lastWeatherInfo.weather
            let temperature = temperatureTextFromWeather(weather, temperatureUnit: defaultTemperatureUnit)
            
            let coordinate: CityCoordinate? = {
                return weather?.cityCoordinate ?? {
                    switch userCity.location {
                    case .coordinate(let coordinate):
                        return coordinate
                    default:
                        return nil
                    }
                }()
            }()
            let title = weather?.cityName ?? userCity.cityName
            view.model = WeatherDetailViewModel(title: title, temperature: temperature, cityCoordinate: coordinate)
        }).disposed(by: disposeBag)
    }
}
