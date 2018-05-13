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
    
    func userCitiesWithWeatherAndRefresher() -> (Observable<[UserCityWithWeather]>, refresher: () -> Void)
    
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
}

private extension UserCityListInteractorImp {
    
    typealias RefreshSubject = PublishSubject<Void>
    
    var userCities: Observable<[UserCity]> {
        return userCitiesProvider.userCities
    }
}

extension UserCityListInteractorImp {
    
    // MARK: - <UserCityListInteractor>

    func userCitiesWithWeatherAndRefresher() -> (Observable<[UserCityWithWeather]>, refresher: () -> Void) {
        
        var last: (() -> Void)?
        
        let observable = Observable<[UserCityWithWeather]>.create { [unowned self] observer in
            
            return self.userCities.subscribe(onNext: { [weak self] (userCities) in
                
                last = {
                    let next: [UserCityWithWeather] = userCities.map { (userCity: $0, weatherInfo: nil) }
                    
                    observer.onNext(next)
                    
                    let locations = userCities.map { $0.location }
                    self?.weatherProvider.queryWeather(for: locations, completion: { (results) in
                        let userCitiesWithWeather = (0..<results.count).map {
                            (userCities[$0], results[$0].value)
                        }
                        DispatchQueue.main.async {
                            observer.onNext(userCitiesWithWeather)
                        }
                    })
                }
                last!()
            })
        }
        let refresher = {
            last?()
            ()
        }
        return (observable, refresher: refresher)
    }

    func delete(_ userCity: UserCity) {
        
        try! userCitiesProvider.delete(userCity)
    }
}
