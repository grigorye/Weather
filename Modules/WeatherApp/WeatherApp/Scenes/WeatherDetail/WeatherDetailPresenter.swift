//
//  WeatherDetailPresenter.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

protocol WeatherDetailPresenter : class {
    
    func loadContent()
}

class WeatherDetailPresenterImp : WeatherDetailPresenter {
    
    let view: WeatherDetailView
    let userCityWithWeather: UserCityWithWeather
    
    init(view: WeatherDetailView, userCityWithWeather: UserCityWithWeather) {
        self.view = view
        self.userCityWithWeather = userCityWithWeather
    }
    
    func loadContent() {
        let (userCity, weather) = userCityWithWeather
        let temperature = temperatureTextFromWeather(weather, temperatureUnit: defaultTemperatureUnit)
        view.model = WeatherDetailViewModel(temperature: temperature, cityName: userCity.cityName, cityCoordinate: weather!.cityCoordinate)
    }
}
