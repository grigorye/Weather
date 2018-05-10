//
//  UserCityListInteractor.swift
//  WeatherApp
//
//  Created by Grigory Entin on 10/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import RxSwift
import Result

protocol UserCityListInteractor {
    
    var userCitiesWithWeather: Observable<[(UserCity, WeatherInfo?)]> { get }
    func delete(_: UserCity)
}

class UserCityListInteractorImp : UserCityListInteractor {
    
    private let userCitiesProvider: UserCitiesProvider
    private let weatherProvider: WeatherProvider

    deinit {()}
    
    init(userCitiesProvider: UserCitiesProvider, weatherProvider: WeatherProvider) {
        
        self.userCitiesProvider = userCitiesProvider
        self.weatherProvider = weatherProvider
    }
    
    func observableUserCitiesWithWeather(userCities: Observable<[UserCity]>) -> Observable<[UserCityWithWeather]> {
        
        return Observable.create { observer in
            
            return userCities.subscribe(onNext: { [weak self] (userCities) in
                
                let next: [UserCityWithWeather] = userCities.map { (userCity: $0, weatherInfo: nil) }
                
                observer.onNext(next)
                
                let cityIds = userCities.map { $0.cityId }
                self?.weatherProvider.queryWeather(forCityIds: cityIds, completion: { (results) in
                    let userCitiesWithWeather = (0..<results.count).map {
                        (userCities[$0], results[$0].value)
                    }
                    DispatchQueue.main.async {
                        observer.onNext(userCitiesWithWeather)
                    }
                })
            })
        }
    }
    
    // MARK: - <UserCityListInteractor>

    var userCitiesWithWeather: Observable<[(UserCity, WeatherInfo?)]> {
        
        return observableUserCitiesWithWeather(userCities: userCitiesProvider.userCities)
    }
    
    func delete(_ userCity: UserCity) {
        
        try! userCitiesProvider.delete(userCity)
    }
}
