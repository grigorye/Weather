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
    
    unowned let view: WeatherDetailView
    let userCityInfoAndLastWeather: UserCityInfoAndLastWeather
    
    init(view: WeatherDetailView, userCityInfoAndLastWeather: UserCityInfoAndLastWeather) {
        self.view = view
        self.userCityInfoAndLastWeather = userCityInfoAndLastWeather
    }
    
    let disposeBag = DisposeBag()
    
    func loadContent() {
        let (userCity, lastWeather) = userCityInfoAndLastWeather
        lastWeather.subscribe(onNext: { [unowned view] (lastWeatherInfo) in
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
